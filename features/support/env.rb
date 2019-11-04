require 'active_support/all'
require 'page-object'
require 'require_all'
require 'rspec'
require 'allure-cucumber'
require 'os'
require 'allure_helper'
require 'qaa/helpers'
require 'qaa/fixtures'
require 'qaa/configuration'
#require 'webdrivers'

include Qaa # rubocop:disable Style/MixinUsage

PROJECT_DIR = File.expand_path(File.dirname(__FILE__) + '../../..')
VENTURE = ENV['VENTURE']
ENVIRONMENT = ENV['ENVIRONMENT']

include AllureCucumber::DSL # rubocop:disable Style/MixinUsage

Configuration.load(VENTURE, "#{PROJECT_DIR}/configs/config.yml")

require_all "#{PROJECT_DIR}/libs/"

AllureHelper.configure do |c|
  c.base_dir = PROJECT_DIR
  c.attachment_dir = 'allure_attachments'
end

PROTOCOL ||= Fixtures.instance['protocol']
BASE_URL ||= Fixtures.instance['base_url']
NUMBER_OF_RETRY ||= Fixtures.instance[:default_values]['number_of_retry']

FileUtils.rm_rf("#{PROJECT_DIR}/#{AllureHelper.config.attachment_dir}")
FileUtils.mkdir_p("#{PROJECT_DIR}/#{AllureHelper.config.attachment_dir}")
LoggerHelper.update_step_for_logger(PROJECT_DIR, AllureHelper.config.attachment_dir)

FileUtils.rm_rf("#{PROJECT_DIR}/#{AllureHelper.config.attachment_dir}")
FileUtils.mkdir_p("#{PROJECT_DIR}/#{AllureHelper.config.attachment_dir}")

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
