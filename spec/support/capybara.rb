require 'capybara/rails'
require 'capybara/rspec'
# require 'capybara-screenshot/rspec'
require 'selenium-webdriver'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome
  )
end

Capybara.javascript_driver = :chrome
Capybara.ignore_hidden_elements = true
