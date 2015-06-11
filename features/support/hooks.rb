After do |scenario|
   page.execute_script "window.close();"
   Capybara.send(:session_pool).delete_if { |key, value| key =~ /selenium/i }
end
