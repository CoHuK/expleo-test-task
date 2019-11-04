module BasePage
  include PageObject

  def loaded?
    raise 'Override me!'
  end

  def wait_until_loaded!
    wait_until { loaded? }
  end

  def javascript_loaded?
    $driver.execute_script <<-JS
    if (document.readyState === 'complete') {
      return true
    } else {
      return false
    }
    JS
  end

  def wait_until_js_loaded!
    wait_until { javascript_loaded? }
  end
end
