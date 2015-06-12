@ignore @update_payment @acceptance
Feature: Update Payment Modal
Users with expired card or last payment failed get modal
User whose card is not expired and has not failed does not get modal
Button on modal to update payment opens the SAM payment information page
No thanks link closes modal

Background:
#	Given I have no browser cookies
	Given I am on the USCP article page
		And The asset headline displays
		And The firefly flyout icon displays in the utility bar
#		And The article page loads
	When I hover on the Login avatar
	Then The user flyout displays
	When I click Login in the flyout
	Then The Login page loads

@modal-displays-noaction
Scenario: Update Payment modal displays
	When I login with "authorized" account that is "expired"
	Then Update Your Payment Information modal displays
	When I click Remind me later link in the modal window
	Then The article page loads
		And The firefly flyout icon does not displays in the utility bar
	When I hover on the Login avatar
	Then The user flyout displays
	When I click Logout in the flyout
	Then The asset headline displays

@modal-displays-update
Scenario: Update Payment displays and user updates credit card information
	When I login with "authorized" account that is "expired"
	Then Update Your Payment Information modal displays
	When I click Update Credit Card Information link in the modal window
	Then The Change your payment page displays
	When I click the cancel button in Change your payment page
	Then The article page loads
	When I hover on the Login avatar
	Then The user flyout displays
	When I click Logout in the flyout
	Then The asset headline displays

@no-modal-display
Scenario: No payment modal displays
	When I login with "authorized" account that is "no_expiration"
	Then Update Your Payment Information modal should not display
	Then The article page loads
	When I hover on the Login avatar
	Then The user flyout displays
	When I click Logout in the flyout
	Then The asset headline displays
