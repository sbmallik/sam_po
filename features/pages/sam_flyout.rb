class NavFlyout
extend Capybara::DSL
include Capybara::DSL

def self
	new
end

def visible?
	page.has_css? '.site-nav-firefly-dropdown'
end

def getLoginButtonElement
	find('.firefly-signin-btn')
end

def getLogoutButtonElement
    find('.ff-logout-btn.sam-returns')
end

end
