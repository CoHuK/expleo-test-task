module WebdriverHelper
  class WebDriverConfig
    class << self
      def chrome_config(platform)
        Selenium::WebDriver::Chrome::Service.driver_path = OS.mac? ? Consts::CHROME_DRIVER_MAC_PATH : Consts::CHROME_DRIVER_LINUX_PATH
        chrome_prefs = {}
        chrome_prefs['profile.default_content_settings.popups'] = 0
        chrome_prefs['disable-popup-blocking'] = true
        chrome_prefs['ignore-certifiate-errors'] = true
        chrome_prefs['download.default_directory'] = Fixtures.instance['download_dir']
        chrome_prefs['credentials_enable_service'] = false
        chrome_prefs['profile.password_manager_enabled'] = false
        options = Selenium::WebDriver::Chrome::Options.new(prefs: chrome_prefs)
        options.add_argument('--disable-fullscreen-tab-detaching')
        options.add_argument('--enable-fullscreen-toolbar-reveal')
        if platform.headless?
          options.add_argument('--headless')
          options.add_argument('--disable-extensions')
          options.add_argument('--disable-gpu')
          options.add_argument('--no-sandbox')
          options.add_argument("--window-size=#{Consts::WINDOW_SIZE}")
          if (platform.remote?)
            options.add_argument(platform.url)
          end
        end
        options
      end

      def firefox_config(platform)
        Selenium::WebDriver::Service.driver_path = OS.mac? ? Consts::FIREFOX_DRIVER_MAC_PATH : Consts::FIREFOX_DRIVER_LINUX_PATH
        profile = Selenium::WebDriver::Firefox::Profile.new
        profile['browser.download.dir'] = Fixtures.instance['download_dir']
        profile['browser.download.folderList'] = 2
        profile['geo.enabled'] = false
        profile['browser.helperApps.alwaysAsk.force'] = false
        profile['browser.download.manager.showWhenStarting'] = false
        profile['browser.helperApps.neverAsk.saveToDisk'] = 'application/csv,application/vnd.ms-excel'
        options = Selenium::WebDriver::Firefox::Options.new(profile: profile)
        if platform.headless?
          options.add_argument('--headless')
          options.add_argument('--disable-extensions')
          options.add_argument('--disable-gpu')
          options.add_argument('--no-sandbox')
        end
        options
      end
    end
  end
end
