require 'minitest/autorun'
require 'dotenv'
Dotenv.load('.env')
require_relative '../lib/greip'

class LookupTest < Minitest::Test
    def test_successful_lookup
        access_token = ENV['TOKEN']
        handler = Greip.create(access_token)
        ip_address = '1.1.1.1'

        result = handler.lookup({ip: ip_address})
        assert_equal ip_address, result.ip
    end
end
