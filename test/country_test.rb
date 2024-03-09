# frozen_string_literal: true

require "minitest/autorun"
require "dotenv"
Dotenv.load(".env")
require_relative "../lib/greip"

class CountryTest < Minitest::Test
  def test_successful_country
    access_token = ENV.fetch("TOKEN", nil)
    handler = Greip.create(access_token)
    country_code = "US"

    result = handler.country({ countryCode: country_code })
    assert_equal country_code, result["countryCode"]
  end
end
