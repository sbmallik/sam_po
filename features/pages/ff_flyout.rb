class FireflyFlyout
extend Capybara::DSL
include Capybara::DSL

def self
    new
end

def getFlyoutClassName
	return '.util-bar-flyout-firefly.open'
end

def verify
    find(getFlyoutClassName)
end

def getFlyoutTitle
    find('.util-bar-flyout-firefly-title').text
end

def checkForAD
	find('.util-bar-flyout-firefly-ad')
end

end
