module WebdriverHelper
  class << self
    def start_driver(platform)
      quit_driver
      WebdriverFactory.get_driver platform
    end

    def quit_driver
      @browser.close unless @browser.nil?
    end
  end
end
