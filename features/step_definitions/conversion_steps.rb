When(/^I choose to convert (.*) (.*) to (.*)$/) do |amount, from_currency, to_currency|
  @amount = amount
  @from_currency = from_currency
  @to_currency = to_currency
  visit ConversionPage do |page|
    page.amount = @amount
    page.choose_currency_from(@from_currency)
    page.choose_currency_to(@to_currency)
  end
end

And(/^I perform conversion$/) do
  on(ConversionPage).convert
end

Then(/^Conversion is done$/) do
  expect(on(ResultPage)).amount eq(@amount)
end