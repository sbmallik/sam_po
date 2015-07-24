Given(/^I have no browser cookies$/) do
	browser = Capybara.current_session.driver.browser
	browser.manage.delete_all_cookies
end

Given(/^I am on the USCP article page$/) do #use article page to log in to avoid high impact ads
	@sam = SamIntegrations.visit('/story/opinion/2014/12/15/new-metered-story-2/3743046/')
#	@sam = SamIntegrations.visit('/story/news/health/blogs/all-about-health/2014/11/19/would-it-kill-anyone-to-reduce-hospital-readmissions/2513067/')
#	@sam = SamIntegrations.new(Capybara.current_session)
#	@sam.visit
#	http://www.usatoday.com/?no_ads=1" to avoid ads on page
end

Then (/^The article page loads$/) do
	expect(@sam).to be_displaying
end

When(/^I hover on the login avatar$/) do
	@sam.getLoginAvatarElement.hover
	@flyout = NavFlyout.new if @flyout.nil?
end

Then(/^The user flyout displays$/) do
	expect(@flyout).to be_visible
end

When(/^I click Login in the flyout$/) do
	@flyout.getLoginButtonElement.click
	@login = LoginPage.new
end

When(/^I click Logout in the flyout$/) do
	@flyout.getLogoutButtonElement.click
end

Then(/^The Login page loads$/) do
	expect(@login).to be_visible
end

When(/^I login with "(.*?)" account that is "(.*?)"$/) do |auth_status, payment_status|
	@login.logIn(auth_status,payment_status)
	@ccmodal = PaymentModal.new
end

Then(/^Update Your Payment Information modal displays$/) do
	expect(@ccmodal).to be_visible
end

Then(/^Update Your Payment Information modal should not display$/) do
	expect(@ccmodal).to be_invisible
end

Then(/^"(.*?)" link displays$/) do |arg1|
	@ccmodal.getUpdateButtonElement
end

When(/^I click Remind me later link in the modal window$/) do
	@ccmodal.getRemindLaterButtonElement.click
end

When(/^I click Update Credit Card Information link in the modal window$/) do
	@ccmodal.getUpdateButtonElement.click
	@chgPI = ChangePaymentInfo.new
end

Then(/^The Change your payment page displays$/) do
	@original_window = page.driver.browser.window_handles.first
	@new_window = page.driver.browser.window_handles.last
	page.driver.browser.switch_to.window @new_window
	expect(@chgPI).to be_visible
end

When(/^I click the cancel button in Change your payment page$/) do
	@chgPI.getCancelButtonElement.click
	page.driver.browser.close
	page.driver.browser.switch_to.window @original_window
end

When(/^I click the (Previous|Next) asset navigation arrow$/) do | direction |
	@sam.clickAssetNavigationArrow(direction)
	wait_for_pageload
end

Then(/^The firefly flyout icon displays in the utility bar$/) do
	expect(@sam).to be_showing_firefly
end

Then(/^The firefly flyout icon does not displays in the utility bar$/) do
	expect(@sam).to be_showing_no_firefly
end
