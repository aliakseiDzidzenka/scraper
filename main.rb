$LOAD_PATH.unshift('.')
require 'scrap_onliner'
require 'capybara'
require 'selenium-webdriver'
require 'csv'
require 'file_handler'

Selenium::WebDriver::Firefox.driver_path = 'driver/geckodriver'
Capybara.default_driver = :selenium

onliner = ScrapOnliner.new(Capybara.current_session)
writer = FileHandler.new('onliner_results')

onliner.scrap_images_src
onliner.scrap_headers
onliner.scrap_descriptions
writer.write_csv([onliner.images_src, onliner.headers, onliner.descriptions])
