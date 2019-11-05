When(/^I choose to convert (.*) (.*) to (.*)$/) do |amount, from_currency, to_currency|
  @from_currency = from_currency
  @to_currency = to_currency
  visit ConversionPage do |page|
    page.amount = amount
    page.choose_currency_from(@from_currency)
    page.choose_currency_to(@to_currency)
  end
end

And(/^I perform conversion$/) do
  on(ConversionPage).convert
end

Then(/^(.*) is the same after convertion$/) do |amount|
  expect(on(ResultPage).amount_from).to eq(amount)
end

And(/^Currencies are the same after convertion$/) do
  expect(on(ResultPage).currencies).to contain_exactly(@from_currency, @to_currency)
end
