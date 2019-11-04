require 'faker'
require 'json'

class Utils
  def self.generate_random_name
    Faker::Name.name
  end

  def self.generate_random_email
    "qa#{Time.now.strftime("%Y%m%d_%H.%M.%S")}_#{Faker::Number.number(3)}@circles.asia"
  end

  def self.generate_random_password
    Faker::Internet.password
  end

  def self.generate_random_phone_number(country_code = '+84')
    "#{country_code}#{Faker::Number.number(9)}"
  end

  def self.generate_random_address
    Faker::Address.street_address
  end

  def self.generate_screenshot_file_name
    "screenshot_#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.png"
  end

  def self.prepare_environment(screenshot_dir, allure_result_dir)
    create_screenshot_dir(screenshot_dir)
    clean_allure_result_dir(allure_result_dir)
  end

  def self.clean_environment
    BrowserHelper.clear_all_cookies
  end

  def self.create_screenshot_dir(screenshot_dir)
    FileUtils.rm_rf(screenshot_dir)
    FileUtils.mkpath(screenshot_dir)
  end

  def self.clean_allure_result_dir(allure_result_dir)
    FileUtils.rm_rf(allure_result_dir)
  end

  def self.create_driver(platform)
    if platform.chrome?
      path = Consts::CHROME_DRIVER_MAC_PATH if OS.mac?
      path = Consts::CHROME_DRIVER_LINUX_PATH if OS.linux?
      Selenium::WebDriver::Chrome.driver_path = path
      options = Selenium::WebDriver::Chrome::Options.new
      profile = Selenium::WebDriver::Chrome::Profile.new
      profile['profile.managed_default_content_settings.images'] = 2 if platform.disable_image?
    end

    if platform.firefox?
      path = Consts::FIREFOX_DRIVER_MAC_PATH if OS.mac?
      path = Consts::FIREFOX_DRIVER_LINUX_PATH if OS.linux?
      Selenium::WebDriver::Firefox.driver_path = path
      options = Selenium::WebDriver::Firefox::Options.new
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile['permissions.default.image'] = 2 if platform.disable_image?
    end

    if platform.headless?
      options.add_argument('--headless')
      options.add_argument('--disable-extensions')
      options.add_argument('--disable-gpu')
      options.add_argument('--no-sandbox')
    end

    Selenium::WebDriver.for(:"#{platform.browser_type}", profile: profile, options: options)
  end

  def self.init_allure_report(allure_result_dir, is_clean_dir)
    AllureRubyAdaptorApi::Config.logging_level = Logger::DEBUG

    AllureCucumber.configure do |c|
      c.output_dir = allure_result_dir
      c.clean_dir = is_clean_dir
      c.issue_prefix = '@ISSUE:'
    end
  end
end
