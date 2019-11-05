@conversion
Feature: Currency Conversion

  @conversion.basic_conversion
  Scenario Outline: I perform conversion from one currency to another
    When I choose to convert <amount> <from_currency> to <to_currency>
    And I perform conversion
    Then <amount> is the same after convertion
    And Currencies are the same after convertion
    And Convertion is done right
    Examples:
      |from_currency|to_currency|amount|
      |GBP          | EUR       | 10   |
      |EUR          | GBP       | 150  |
      |USD          | INR       | 20   |
      |INR          | USD       | 5000 |
      |MXN          | SAR       | 5000 |
