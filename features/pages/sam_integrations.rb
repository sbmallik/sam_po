class SamIntegrations
extend Capybara::DSL
include Capybara::DSL

#def initialize(session)
#	@session = session
#end 

def self.visit(path_name)
	page.visit ui_url path_name
	new
end

def checkPageLoad
	find('#overlay div.transition-wrap article.asset')
end
 
def checkHeadline
	find('.asset-headline')
end

def loginAvatar
	find('.site-nav-firefly-link').hover
	NavFlyout.new
end

def getFFFlyoutButtonClassName
	return '.util-bar-btn-firefly'
end

def checkFFFlyoutButton
	find(getFFFlyoutButtonClassName)
end

def clickFFFlyoutButton
	checkFFFlyoutButton.click
	FireflyFlyout.new
end

def clickAssetNavigationArrow(direction)
	find(".overlay-content-arrows-#{direction.downcase}-wrap").click
end

def checkForFFFLyout
	@fireflyFlyout = FireflyFlyout.new
	@fireflyFlyout.getFlyoutClassName
end

end
