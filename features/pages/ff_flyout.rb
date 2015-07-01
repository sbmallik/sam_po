class FireflyFlyout
extend Capybara::DSL
include Capybara::DSL

def self
    new
end

def visible?
	page.has_css? '.util-bar-flyout-firefly.open'
end

def getFlyoutTitle
    find('.util-bar-flyout-firefly-title').text
end

def checkForAD
	find('.util-bar-flyout-firefly-ad')
end

def getFlyoutTitleElement
    find('.util-bar-flyout-firefly-title')
end

end
