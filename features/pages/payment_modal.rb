class PaymentModal
extend Capybara::DSL
include Capybara::DSL
include RSpec::Matchers

def self
	new
end

def visible?
	page.has_css? '.expired-card-modal-wrapper'
end

def invisible?
	page.has_no_css? '.expired-card-modal-wrapper'
end

#def updateCCInfo
#	@page_element = getUpdateButtonElement
#	expected_url = @page_element[:href] 
#	@page_element.click
#end

def getUpdateButtonElement
	find('.cc-payment-button')
end

def getRemindLaterButtonElement
	find('.cc-remind-later-link')
end

end
