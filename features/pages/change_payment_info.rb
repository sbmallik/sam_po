class ChangePaymentInfo
extend Capybara::DSL
include Capybara::DSL

def self
    new
end

def verify
    find('.section-validate')
end

def clickContinue
    find('.primary.next').click
end

def clickCancel
    find('.tertiary').click
end

end

