require 'minitest/autorun'
require 'dotenv'
Dotenv.load('.env')
require_relative '../lib/greip'

class EmailValidationTest < Minitest::Test
    def test_successful_country
        access_token = ENV['TOKEN']
        handler = Greip.create(access_token)
        email = 'name@domain.com'

        result = handler.email_validation({ email: email })
        assert_equal result.isValid, false
    end
end
