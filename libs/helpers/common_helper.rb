class CommonHelper
  class << self
    def get_environment_information
      env_info = {}

      env_info['Environment'] = ENV['ENVIRONMENT']
      env_info['Browser'] = ENV['BROWSER']
      env_info['Browser_options'] = ENV['BROWSER_OPTIONS']
      env_info['Venture'] = ENV['VENTURE']
      env_info['Attach_screenshot'] = ENV['ATTACH_SCREENSHOT']

      env_info
    end
  end
end
