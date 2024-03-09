# frozen_string_literal: true

require "minitest/autorun"
require "dotenv"
Dotenv.load(".env")
require_relative "../lib/greip"

class ProfanityTest < Minitest::Test
  def test_successful_country
    access_token = ENV.fetch("TOKEN", nil)
    handler = Greip.create(access_token)
    text = "This is just a normal text (without profanity)"

    result = handler.profanity({ text: text })
    assert_equal result["isSafe"], true
  end
end
