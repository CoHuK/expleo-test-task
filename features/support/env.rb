require 'active_support/all'
require 'page-object'
require 'require_all'
require 'rspec'
require 'allure-cucumber'
require 'os'
require 'qaa/helpers'
require 'qaa/fixtures'
require 'qaa/configuration'

include Qaa # rubocop:disable Style/MixinUsage

PROJECT_DIR = File.expand_path(File.dirname(__FILE__) + '../../..')

# Be careful with modifications! TODO: Add dummy check
SCREENSHOT_DIR = "#{PROJECT_DIR}/gen/screenshots".freeze
FileUtils.rm_rf(SCREENSHOT_DIR)
FileUtils.mkdir_p(SCREENSHOT_DIR)

# WebDrivers locations
CHROME_DRIVER_MAC_PATH = "#{PROJECT_DIR}/drivers/chromedriver_mac".freeze
FIREFOX_DRIVER_MAC_PATH = "#{PROJECT_DIR}/drivers/geckodriver_mac".freeze
CHROME_DRIVER_LINUX_PATH = "#{PROJECT_DIR}/drivers/chromedriver_linux64".freeze
FIREFOX_DRIVER_LINUX_PATH = "#{PROJECT_DIR}/drivers/geckodriver_linux64".freeze

Configuration.load(ENV['BROWSER'], "#{PROJECT_DIR}/configs/config.yml")

require_all "#{PROJECT_DIR}/libs/"

Allure.configure do |c|
  c.results_directory = "gen/allure-results"
  c.clean_results_directory = true
  c.logging_level = Logger::DEBUG
end
ALLURE_ENVIRONMENT = {}

$platform = Platform.new(ENV['BROWSER'],
                         ENV['BROWSER_OPTIONS'],
                         url: ENV['REMOTE_URL'],
                         remote_driver: ENV['REMOTE_DRIVER'])
ALLURE_ENVIRONMENT.merge!($platform.to_hash)
World(PageObject::PageFactory)

# check for CUSTOM_TIMEOUT to return nil or empty
custom_timeout = if ENV['CUSTOM_TIMEOUT'].to_s.empty?
                   Fixtures.instance[:default_values]['default_timeout']
                 else
                   ENV['CUSTOM_TIMEOUT'].to_i
                 end
Watir.default_timeout = custom_timeout

at_exit {Allure.add_environment(ALLURE_ENVIRONMENT)}
