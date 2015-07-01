class ChangePaymentInfo
extend Capybara::DSL
include Capybara::DSL

def self
    new
end

def visible?
    page.has_css? '.section-validate'
end

def getContinueButtonElement
	find('.primary.next')
end

def getCancelButtonElement
	find('.tertiary')
end

end
