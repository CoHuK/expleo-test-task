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
  if scenario.failed?
    Utils.attach_screenshot(@browser, true)
  end
  WebdriverHelper.quit_driver
end

AfterStep do
  Utils.attach_screenshot(@browser)
end

Around('@Ex_tag1') do |scenario, block|
  # Will round around a scenario
end
