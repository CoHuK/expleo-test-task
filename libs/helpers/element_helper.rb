class ElementHelper
  class << self
    def get_inner_text(element)
      element.attribute('innerText')
    end
  end
end
