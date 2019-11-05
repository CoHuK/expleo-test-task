require 'faker'
require 'json'

class Utils
  def self.generate_random_name
    Faker::Name.name
  end

  def self.generate_random_email
    "qa#{Time.now.strftime("%Y%m%d_%H.%M.%S")}_#{Faker::Number.number(3)}@strongin.qa"
  end

  def self.generate_random_password
    Faker::Internet.password
  end

  def self.generate_random_phone_number(country_code = '+65')
    "#{country_code}#{Faker::Number.number(8)}"
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

  def self.attach_screenshot(browser, test_case=false)
    file_path = "#{SCREENSHOT_DIR}/#{Utils.generate_screenshot_file_name}"
    browser.screenshot.save(file_path)
    Allure.add_attachment(name: "Screenshot_#{Utils.generate_screenshot_file_name}", source: File.new(file_path, "r"), type: Allure::ContentType::PNG, test_case: test_case)
  end
end
