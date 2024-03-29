# frozen_string_literal: true

require "minitest/autorun"
require "dotenv"
Dotenv.load(".env")
require_relative "../lib/greip"

class IBANValidationTest < Minitest::Test
  def test_successful_country
    access_token = ENV.fetch("TOKEN", nil)
    handler = Greip.create(access_token)
    iban = "DE89370400440532013000"

    result = handler.iban_validation({ iban: iban })
    assert_equal result["isValid"], true
  end
end
