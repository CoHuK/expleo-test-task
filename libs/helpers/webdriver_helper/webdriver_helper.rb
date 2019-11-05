module WebdriverHelper
  @@browser = nil
  class << self
    def start_driver(platform)
      @@browser = WebdriverFactory.get_driver platform
    end

    def quit_driver
      @@browser.close unless @@browser.nil?
    end
  end
end
