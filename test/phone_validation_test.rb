# frozen_string_literal: true

require "minitest/autorun"
require "dotenv"
Dotenv.load(".env")
require_relative "../lib/greip"

class PhoneValidationTest < Minitest::Test
  def test_successful_country
    access_token = ENV.fetch("TOKEN", nil)
    handler = Greip.create(access_token)
    phone = "1234567890"
    country_code = "US"

    result = handler.phone_validation({ phone: phone, countryCode: country_code })

    assert_equal result["isValid"], false
  end
end
