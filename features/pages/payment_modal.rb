class PaymentModal
extend Capybara::DSL
include Capybara::DSL

def self
	new
end

def checkifexists
	find(getModalWindowClassName)
end

def getModalWindowClassName
	return '.expired-card-modal-wrapper'
end

def updateCCInfo
	@page_element = checkCCInfo
	expected_url = @page_element[:href] 
	@page_element.click
	ChangePaymentInfo.new
end

def remindLater
	checkRemindLater.click
end

def checkCCInfo
	find('.cc-payment-button')
end

def checkRemindLater
	find('.cc-remind-later-link')
end

end
