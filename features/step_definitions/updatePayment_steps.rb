Given(/^I have no browser cookies$/) do
	browser = Capybara.current_session.driver.browser
	browser.manage.delete_all_cookies
end

Given(/^I am on the USCP article page$/) do #use article page to log in to avoid high impact ads
	@sam = SamIntegrations.visit('/story/news/health/blogs/all-about-health/2014/11/19/would-it-kill-anyone-to-reduce-hospital-readmissions/2513067/')
#	@sam = SamIntegrations.new(Capybara.current_session)
#	@sam.visit
#	http://www.usatoday.com/?no_ads=1" to avoid ads on page
end

Then (/^The article page loads$/) do
#	expect(page).to have_selector('#overlay div.transition-wrap article.asset')
	@sam.checkPageLoad
end

When(/^I hover on the Login avatar$/) do
	@flyout = @sam.loginAvatar
end

Then(/^The user flyout displays$/) do
	@flyout.verify
end

When(/^I click Login the flyout$/) do
	@login = @flyout.navLogin
end

Then(/^The Login page loads$/) do
	@login.verify
end

When(/^I login with "(.*?)" account that is "(.*?)"$/) do |auth_status, payment_status|
	@ccmodal = @login.logIn(auth_status,payment_status)
end

Then(/^Update Your Payment Information modal displays$/) do
#	expect(page).to have_css('div.expired-card-modal-wrapper')
#	@ccmodal = PaymentModal.new
	@ccmodal.checkifexists
end

Then(/^"(.*?)" link displays$/) do |arg1|
	@ccmodal.checkCCInfo
end

When(/^I click Remind me later link in the modal window$/) do
	@ccmodal.remindLater
end

Then(/^The asset headline displays$/) do
	@sam.checkHeadline
end

Then(/^Update Your Payment Information modal does not display$/) do
	pending # express the regexp above with the code you wish you had
end

Then(/^A new window for the SAM Change Your Payment page opens$/) do
	pending # express the regexp above with the code you wish you had
end

When(/^I click Update Credit Card Information link in the modal window$/) do
	@chgPI = @ccmodal.updateCCInfo
end

Then(/^The Change your payment page displays$/) do
	@original_window = page.driver.browser.window_handles.first
	@new_window = page.driver.browser.window_handles.last
	page.driver.browser.switch_to.window @new_window
	@chgPI.verify
end

When(/^I click the cancel button in Change your payment page$/) do
	@chgPI.clickCancel
	page.driver.browser.close
	page.driver.browser.switch_to.window @original_window
end
