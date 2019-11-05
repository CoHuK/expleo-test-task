class ResultPage
  include PageObject
  include BasePage

  text_field(:amount_from, id: 'cc-amount-from')
  text_field(:amount_to, id: 'cc-amount-to')
  element(:source_currency, xpath: '//button[@data-id="sourceCurrency"]//span/div//span')
  element(:target_currency, xpath: '//button[@data-id="targetCurrency"]//span/div//span')

  def currencies
    [source_currency_element.text, target_currency_element.text]
  end
end
