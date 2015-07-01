class SamIntegrations
	extend Capybara::DSL
	include Capybara::DSL
	include RSpec::Matchers

#	def initialize(session)
#		@session = session
#	end 

	FIREFLY_BUTTON_CLASS = '.util-bar-btn-firefly'

	def self.visit(path_name)
		page.visit ui_url path_name
		new
	end

	def displaying?
		page.has_css? '#overlay div.transition-wrap article.asset'
	end

	def showing_firefly?
		page.has_css? FIREFLY_BUTTON_CLASS
	end

	def showing_no_firefly?
		page.has_no_css? FIREFLY_BUTTON_CLASS
	end

	def getLoginAvatarElement
		find('.site-nav-firefly-link')
	end

	def getFFFlyoutButtonElement
		find(FIREFLY_BUTTON_CLASS)
	end

	def getAssetNavigationArrowElement(direction)
		find(".overlay-content-arrows-#{direction.downcase}-wrap")
	end

end
