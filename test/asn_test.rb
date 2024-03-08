# frozen_string_literal: true

require 'minitest/autorun'
require 'dotenv'
Dotenv.load('.env')
require_relative '../lib/greip'

class ASNTest < Minitest::Test
  def test_successful_country
    access_token = ENV['TOKEN']
    handler = Greip.create(access_token)
    asn = 'AS01'

    result = handler.asn({ asn: asn })
    assert_equal asn, result.asn
  end
end
