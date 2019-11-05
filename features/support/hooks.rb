Before do
  # Do something before each scenario.
end

Before do |scenario|
  # The +scenario+ argument is optional, but if you use it, you can get the title,
  # description, or name (title + description) of the scenario that is about to be
  # executed.
  @browser = WebdriverHelper.start_driver $platform
end

After do |scenario|
  # Do something after each scenario.
  # The +scenario+ argument is optional, but
  # if you use it, you can inspect status with
  # the #failed?,

  $after_scenario = true
  if scenario.failed?
    file_path = "#{PROJECT_DIR}/screenshots/#{Utils.generate_screenshot_file_name}"
    @browser.screenshot.save(file_path)
    Allure.add_attachment(name: "Screenshot", source: File.new(file_path, "r"), type: Allure::ContentType::PNG, test_case: true)
  end
  WebdriverHelper.quit_driver
end

AfterStep do
  file_path = "#{PROJECT_DIR}/screenshots/#{Utils.generate_screenshot_file_name}"
  @browser.screenshot.save(file_path)
  Allure.add_attachment(name: "Screenshot_#{Utils.generate_screenshot_file_name}", source: File.new(file_path, "r"), type: Allure::ContentType::PNG)
end

Around('@Ex_tag1') do |scenario, block|
  # Will round around a scenario
end