# frozen_string_literal: true

require "minitest/autorun"
require "dotenv"
Dotenv.load(".env")
require_relative "../lib/greip"

class BulkLookupTest < Minitest::Test
  def test_successful_bulk_lookup
    access_token = ENV.fetch("TOKEN", nil)
    handler = Greip.create(access_token)
    ip_address = "1.1.1.1"

    result = handler.bulk_lookup({ ips: [ip_address] })
    assert_equal ip_address, result.dig(ip_address, "ip", "address")
  end
end
