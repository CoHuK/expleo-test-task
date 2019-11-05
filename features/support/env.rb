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
VENTURE = ENV['VENTURE']
ENVIRONMENT = ENV['ENVIRONMENT']
NUMBER_OF_RETRY ||= Fixtures.instance[:default_values]['number_of_retry']

Configuration.load(VENTURE, "#{PROJECT_DIR}/configs/config.yml")

require_all "#{PROJECT_DIR}/libs/"

Allure.configure do |c|
  c.results_directory = "gen/allure-results"
  c.clean_results_directory = true
  c.logging_level = Logger::DEBUG
end

FileUtils.rm_rf("#{PROJECT_DIR}/screenshots")  # hardcoded for safety
FileUtils.mkdir_p("#{PROJECT_DIR}/screenshots")


$platform = Platform.new(ENV['BROWSER'],
                         ENV['BROWSER_OPTIONS'],
                         url: ENV['REMOTE_URL'],
                         remote_driver: ENV['REMOTE_DRIVER'])
World(PageObject::PageFactory)

# check for CUSTOM_TIMEOUT to return nil or empty
custom_timeout = if ENV['CUSTOM_TIMEOUT'].to_s.empty?
                   Fixtures.instance[:default_values]['default_timeout']
                 else
                   ENV['CUSTOM_TIMEOUT'].to_i
                 end
Watir.default_timeout = custom_timeout
