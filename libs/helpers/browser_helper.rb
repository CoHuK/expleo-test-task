class BrowserHelper
  class << self
    def get_all_cookies
      $driver.manage.all_cookies
    end

    def load_cookies(cookie_array)
      cookie_array.each do |cookie|
        $driver.manage.add_cookie(cookie)
      end
    end

    def clear_all_cookies
      $driver.manage.delete_all_cookies
    end

    def refresh_page
      $driver.navigate.refresh
    end

    def navigate_to(url)
      $driver.navigate.to url
    end

    def scroll_down
      $driver.execute_script('window.scrollBy(0,1000)')
    end

    def scroll_to_element(element, direction = 'down')
      case direction
      when 'down'
        NUMBER_OF_RETRY.times do
          $driver.execute_script('window.scrollBy(0, 300)')
          break if element.exist? && element.present?
        end
      when 'up'
        NUMBER_OF_RETRY.times do
          $driver.execute_script('window.scrollBy(0, -300)')
          break if element.exist? && element.present?
        end
      else
        puts 'Unknown parameter'
      end
    end

    def click_element_by_javascript(element)
      $driver.execute_script('arguments[0].click();', element)
    end
  end
end
