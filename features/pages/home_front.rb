class HomeFront
	extend Capybara::DSL
	include Capybara::DSL
#	include RSpec::Matchers

	def self.visit(path_name)
		page.visit ui_url path_name
		new
	end

	def getLoginAvatarElement
		find('.site-nav-firefly-link')
	end

	def getAssetFromHeadlines(position)
		within('.headline-page') do
			find(".hgpm-link-#{position.to_i}")
		end
	end

	def showing_hero_module?
		page.has_css? '.hero-primary-module'
	end

	def getHeadlinesStatus
		first('.headline-grid-primary-module')
	end

end
