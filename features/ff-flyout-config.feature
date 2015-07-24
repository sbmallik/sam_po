@uscp @fly-out
Feature: The USCP sites has a fixed number of free assets that can be viewed by an anonymous user before the roadblock page is displayed.

Scenario: Check for the fly-out if the asset is metered
	Given I am on the USCP homepage
	Then The home page loads
	When I hover on the login avatar in navigation header
	Then The user flyout displays
		And The login button displays in the user flyout

	When I navigate to the next metered asset and I check for the following text:
|	flyout-text							|
|	TEST FIRST ARTICLE					|
|	3 ARTICLES REMAINING TEST MESSAGE	|
|	2 ARTICLES REMAINING TEST MESSAGE	|
|	1 ARTICLE REMAINING TEST MESSAGE	|
|	TEST LAST ARTICLE					|

	When I click the right navigation arrow
	Then I should see the asset page
		And I ensure that a metered asset is loaded
		And The roadblock page displays
