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

	def self
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

	def getAssetOverlayStatus
		first('article.asset')
	end

	def getLoginAvatarElement
		find('.site-nav-firefly-link')
	end

	def getFFFlyoutButtonStatus
		first(FIREFLY_BUTTON_CLASS)
	end

	def getFFFlyoutButtonElement
		find(FIREFLY_BUTTON_CLASS)
	end

	def getFFFlyoutStatus
		first('.util-bar-flyout-firefly-title')
	end

	def getFFFlyoutTitleElement
		find('.util-bar-flyout-firefly-title')
	end

	def getAssetNavigationArrowElement(direction)
		find(".overlay-content-arrows-#{direction.downcase}-wrap")
	end

	def getRoadblockStatus
		first("iframe[name='dontmiss']")
	end

	def getRoadblockElement
		within_frame('dontmiss') do
			find('.firefly.full.trial-expired')
		end
	end

end
