module WebdriverHelper
  class WebdriverFactory
    def self.get_driver(platform)
      opts = {}
      opts[:url] = platform.url if platform.remote?
      case platform.browser.name
      when Browser.chrome.name
        opts[:options] = WebDriverConfig.chrome_config(platform)
        Watir::Browser.new(:chrome, opts)
      when Browser.firefox.name
        opts[:options] = WebDriverConfig.firefox_config(platform)
        driver = Watir::Browser.new(:firefox, opts)
        driver.manage.window.maximize
        driver
      end
    end
  end
end
