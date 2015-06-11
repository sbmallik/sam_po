require 'rspec/expectations'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'timeout'

$base_url = ENV["ACCEPTANCE_TEST_HOST"] || "http://easybtn-stage.usatoday.com"
Capybara.app_host = $base_url

if ENV['HEADLESS']
  require 'capybara/poltergeist'
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(
      app,
      window_size: [1280, 1024]#,
      #debug:       true
    )
  end
  Capybara.default_driver    = :poltergeist
  Capybara.javascript_driver = :poltergeist
else
  if ENV['LOCAL']
    Capybara.default_driver = :selenium
  else
    require 'selenium'
    require_relative 'extensions/fast-selenium'
    caps = Selenium::WebDriver::Remote::Capabilities.new
    caps['browser'] = 'Firefox'
    caps['browser_version'] = '34'
    caps['os'] = 'Windows'
    caps['os_version'] = "8"
    caps['resolution'] = '1280x1024'
    # caps['browserstack.debug'] = true
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120
    Capybara.default_driver = :selenium
    Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app,
      :browser => :remote,
      :url => (ENV["SELENIUM_HOST"] or "http://jonathanhensley1:yZ6B77ytDSQdpVjG8Npz@hub.browserstack.com/wd/hub"),
      :desired_capabilities => caps,
      :http_client => client)
    end
  end
end


AfterStep("~@popover") do
  # Close any transition ads which may have opened
  # so as not to interfere with the test in progress.
  ad = first(".partner-overlay-close")
  ad.click unless ad.nil?
end

Before do
  window = Capybara.current_session.driver.browser.manage.window
  window.resize_to(1280,1024)
end

After do |s|
  # Tell Cucumber to quit after this scenario is done - if it failed.
  Cucumber.wants_to_quit = true if s.failed?
end

Capybara.default_wait_time = 90
Capybara.default_selector = :css
World(RSpec::Matchers)

def ui_url(path)
  build_qpm = ""
  if !path.include? "build_number"
    if path.include? "?"
      build_qpm = "&build_number=" + ENV['BUILD_NUMBER'].to_s
    else
      build_qpm = "?build_number=" + ENV['BUILD_NUMBER'].to_s
    end
  end
  if !path.include? "://"
    $base_url.to_s + path + build_qpm
  else
    path + build_qpm
  end
end

def validate_url(page_url)
  url = URI.parse(page_url)
  req = Net::HTTP::Get.new(url)
  res = Net::HTTP.start(url.host, url.port) do |http|
    http.request(req) # Perform the GET request.
  end
  if res.code.to_i.between?(300, 303)
    # We've nailed a redirect, so grab the location string
    # provided in the response and validate it instead.
    validate_url (res.get_fields "location").first
  else
    expect(res.code.to_s).to match("200")
  end
end

def wait_for_pageload(reloads=0)
  start = Time.now
  page_ready = false
  find('body')
  while !page_ready
    begin
      page.execute_script("require(['admanager','managers/requestmanager','managers/trafficcop'],function(AdManager, RequestManager, TrafficCop){ window.page_ready = TrafficCop.getAnimationCompletion().state() === 'resolved' && RequestManager.done().state() === 'resolved' && AdManager.isPageLoaded() == true; })")
    rescue
    end
    page_ready = page.execute_script("return window.page_ready")
    break if page_ready == true
    if Time.now > start + Capybara.default_wait_time
      if reloads >= 3
        fail "The page wasn't ready - either it never loaded, never finished animating or requests never finished"
      else
        visit ui_url(current_url)
        wait_for_pageload(reloads + 1)
      end
    end
    sleep 0.5
  end
end

def wait_for_animations()
  start = Time.now
  animations_complete = false
  find('body')
  while !animations_complete
    begin
      page.execute_script("require(['managers/trafficcop'],function(TrafficCop){ window.animations_complete = TrafficCop.getAnimationCompletion().state() === 'resolved' })")
    rescue
    end
      animations_complete = page.execute_script("return window.animations_complete")
    break if animations_complete
    if Time.now > start + Capybara.default_wait_time
      fail "Animations did not complete"
    end
    sleep 0.5
  end
end

def clear_cookies
  browser = Capybara.current_session.driver.browser
  browser.manage.delete_all_cookies
end

def sam_login(email="", password="")
  fill_in('username', :with => email)
  fill_in('password', :with => password)
  find('main.login div.page form fieldset.bottomButtons button.primary.left.last').click
end
