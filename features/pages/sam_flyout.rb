class NavFlyout
extend Capybara::DSL
include Capybara::DSL

def self
	new
end

def verify
	find('.site-nav-firefly-dropdown')
end

def navLogin
	find('.firefly-signin-btn').click
	LoginPage.new
end

def navLogout
    find('.ff-logout-btn.sam-returns').click
end

end
