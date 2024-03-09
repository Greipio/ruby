# frozen_string_literal: true

require "minitest/autorun"
require "dotenv"
Dotenv.load(".env")
require_relative "../lib/greip"

class PaymentFraudTest < Minitest::Test
  def test_successful_country
    access_token = ENV.fetch("TOKEN", nil)
    handler = Greip.create(access_token)
    data = {
      transaction_amount: 100.00,
      currency: "USD"
    }

    result = handler.payment_fraud({ data: data })
    assert_instance_of(Integer, result["score"])
  end
end
