class Platform
  attr_accessor :browser, :browser_options, :url, :remote_driver

  def initialize(browser_type, browser_options, url: nil, remote_driver: false)
    @browser = Browser.new(browser_type)
    @browser_options = browser_options || ''
    @url = url
    @remote_driver = true if url
  end

  def headless?
    @browser_options.include?('headless')
  end

  def disable_image?
    @browser_options.include?('disable_image')
  end

  def chrome?
    @browser == 'chrome'
  end

  def firefox?
    @browser == 'firefox'
  end

  def remote?
    @remote_driver
  end

  def to_hash
    result = {browser: @browser.name,
    browser_options: @browser_options}
    result[:browser_url] = @url if remote?
    result
  end
end
