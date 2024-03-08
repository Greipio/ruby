require 'minitest/autorun'
require 'dotenv'
Dotenv.load('.env')
require_relative '../lib/greip'

class PhoneValidationTest < Minitest::Test
    def test_successful_country
        access_token = ENV['TOKEN']
        handler = Greip.create(access_token)
        phone = '1234567890'
        countryCode = 'US'

        result = handler.phone_validation({ phone: phone, countryCode: countryCode })

        assert_equal result.isValid, false
    end
end
