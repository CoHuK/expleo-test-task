module WebdriverHelper
  class WebdriverFactory
    def self.get_driver(platform)
      # get remote url when the tests have to be executed on remote machine ie., docker, etc.,
      opts = {}
      if (platform.remote?)
        opts[:url] = platform.url
      end
      case platform.browser.name
      when Browser.chrome.name
        opts[:options] = WebDriverConfig.chrome_config(platform)
        #Selenium::WebDriver::Chrome::Driver.new(opts)
        Watir::Browser.new(:chrome, opts)
      when Browser.firefox.name
        opts[:options] = WebDriverConfig.firefox_config(platform)
        #driver = Selenium::WebDriver::Firefox::Driver.new(opts)
        driver = Watir::Browser.new(:firefox, opts)
        driver.manage.window.maximize
        driver
      end
    end
  end
end
