class ConversionPage
  include PageObject
  include BasePage

  page_url "https://transferwise.com/ie/currency-converter"

  text_field(:amount, id: 'cc-amount')
  button(:from_currency, xpath: '//button[@data-id="sourceCurrency"]')
  element(:source_currency, xpath: '//button[@data-id="sourceCurrency"]//span/div//span')
  text_field(:search, xpath: '//input[@aria-label="Search"]')
  text_field(:search2, xpath: '//input[@aria-label="Search"]')
  element(:found_currency, class: 'selected active')
  button(:to_currency, xpath: '//button[@data-id="targetCurrency"]')
  element(:target_currency, xpath: '//button[@data-id="targetCurrency"]//span/div//span')
  button(:convert, id: 'convert')

  def choose_currency(currency, which_element)
    unless currency == which_element.text
      which_element.click
      @browser.send_keys(currency)
      @browser.send_keys :enter
    end
  end

  def choose_currency_from(currency)
    choose_currency(currency, source_currency_element)
  end

  def choose_currency_to(currency)
    choose_currency(currency, target_currency_element)
  end
end