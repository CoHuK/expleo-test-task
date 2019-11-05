class Browser
  attr_reader :name

  BROWSERS = %w[chrome firefox].freeze
  BROWSERS.each do |name|
    define_method "#{name}?" do
      @name == name
    end
  end

  class << self
    BROWSERS.each do |name|
      define_method name do
        Browser.new(name)
      end
    end
  end

  def initialize(browser_name)
    if BROWSERS.include? browser_name
      @name = browser_name
    else
      raise 'Unsupported browser name'
    end
  end
end
