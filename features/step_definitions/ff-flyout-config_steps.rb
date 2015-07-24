Given(/^I have cleared browser cookies$/) do
	clear_browser_cookies
end

Given(/^I am on the USCP homepage$/) do
	@rocHome = HomeFront.visit('/')
	wait_for_pageload
end

Then(/^The home page loads$/) do
	expect(@rocHome).to be_showing_hero_module
end

When(/^I hover on the login avatar in navigation header$/) do
	@rocHome.getLoginAvatarElement.hover
	@flyout = NavFlyout.new if @flyout.nil?
end

Then(/^The login button displays in the user flyout$/) do
	@flyout.getLoginButtonElement
end

When(/^I click the first asset in the headline grid$/) do
        iterator = 1
        until(/(\D+)/.match(@rocHome.getAssetFromHeadlines(iterator)[:href][/[^\/]+\/$/][0..-2]).nil?) do
            iterator += 1
            break if iterator == 10
        end
        click_page_link do
			@page_element = @rocHome.getAssetFromHeadlines(iterator)
		end
		@assetPage = SamIntegrations.new
end

Then(/^I should see the asset page$/) do
	wait_for_pageload
	expect(current_path).to match($expected_path)
end

Then(/^I ensure that a metered asset is loaded$/) do
	while @assetPage.getFFFlyoutButtonStatus.nil? do
#		unless first("iframe[name='dontmiss']").nil?
		unless @assetPage.getRoadblockStatus.nil?
			break
		end
		step %{I click the right navigation arrow}
		step %{I should see the asset page}
	end
end	

When(/^I navigate to the next metered asset and I check for the following text:$/) do | table |
	table.hashes .each do | hsh |
		step %{I navigate to the next asset}
		step %{I should see the asset page}
		step %{I ensure that a metered asset is loaded}
		step %{I click the metered icon}
		step %{The text "#{hsh['flyout-text']}" displays in the fly-out}
	end
end

When(/^I click the metered icon$/) do
	if @assetPage.getFFFlyoutStatus.nil?
		@assetPage.getFFFlyoutButtonElement.click
	end
end

When(/^I click the right navigation arrow$/) do
	click_page_link do
		@page_element = @assetPage.getAssetNavigationArrowElement('next')
	end
end

When(/^I navigate to the next asset$/) do
	if @assetPage.nil?
		step %{I click the first asset in the headline grid}
	else
		step %{I click the right navigation arrow}
	end
end

Then(/^The text "(.*?)" displays in the fly-out$/) do | flyout_title |
	expect(@assetPage.getFFFlyoutTitleElement.text).to match(flyout_title)
end

Then(/^The roadblock page displays$/) do 
#	within_frame('dontmiss') do
#		expect(page).to have_css('.firefly.full.trial-expired')
#	end
	@assetPage.getRoadblockElement
end
