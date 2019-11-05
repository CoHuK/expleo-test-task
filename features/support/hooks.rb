Before do
  # Do something before each scenario.
end

Before do |scenario|
  # The +scenario+ argument is optional, but if you use it, you can get the title,
  # description, or name (title + description) of the scenario that is about to be
  # executed.
  @browser = WebdriverHelper.start_driver $platform

  @scenario = scenario
  @step_index = 0
  @tests_steps = scenario.test_steps
  @current_step_name = @tests_steps[@step_index].to_s
end

After do |scenario|
  # Do something after each scenario.
  # The +scenario+ argument is optional, but
  # if you use it, you can inspect status with
  # the #failed?,

  $after_scenario = true
  if scenario.failed?
    file_path = "#{AllureHelper.config.attachment_dir}/#{Utils.generate_screenshot_file_name}"
    AllureHelper.attach_content('Selenium page source', @browser.html, AllureHelper::ALLURE_TYPE_HTML, false)
    @browser.screenshot.save(file_path)
    AllureHelper.generate_step_log_and_report(scenario, @current_step_name, AllureHelper.config.attachment_dir)
  end
  WebdriverHelper.quit_driver
end

AfterStep do
  file_path = "#{AllureHelper.config.attachment_dir}/#{Utils.generate_screenshot_file_name}"
  @browser.screenshot.save(file_path)
  AllureHelper.generate_step_log_and_report(@scenario, @current_step_name, AllureHelper.config.attachment_dir)
  @step_index += 2
  @current_step_name = @tests_steps[@step_index].to_s
end

Around('@Ex_tag1') do |scenario, block|
  # Will round around a scenario
end