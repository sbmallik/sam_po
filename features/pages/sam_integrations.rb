class SamIntegrations
extend Capybara::DSL
include Capybara::DSL

#def initialize(session)
#	@session = session
#end 

def self.visit(path_name)
#	page.visit ui_url '/story/news/health/blogs/all-about-health/2014/11/19/would-it-kill-anyone-to-reduce-hospital-readmissions/2513067/'
	page.visit ui_url path_name
	new
end

def checkPageLoad
	find('.#overlay div.transition-wrap article.asset')
end
 
def checkHeadline
	find('.asset-headline')
end

def loginAvatar
	find('.site-nav-firefly-link').hover
	NavFlyout.new
end

end
