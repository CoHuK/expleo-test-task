When(/^I choose to convert (.*) (.*) to (.*)$/) do |amount, from_currency, to_currency|
  @amount = amount
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


And(/^Convertion is done right$/) do
  expect(on(ResultPage).calcucated_conversion(@amount)).to be_within(@amount.to_f / 10000).of(on(ResultPage).amount_to.to_f)
  # Test case for 0 conversion result is intentionally skipped
end
