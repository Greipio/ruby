# frozen_string_literal: true

require_relative 'greip/constants'

require 'json'
require 'net/http'
require 'uri'

module Greip
  class GreipHandler
    def initialize(token)
      @token = token
    end

    def lookup(options)
      ip = options[:ip] || ""
      params = options[:params] || []
      lang = (options[:lang] || "EN").upcase
      mode = options[:mode] || "live".downcase

      #? Validate the ip variable
      if ip.length < 7
        raise StandardError, "You should pass the `ip` parameter."
      end

      #? Validate the params variable items
      params.each do |per_param|
        if per_param.length > 0 && !AVAILABLE_GEOIP_PARAMS.include?(per_param)
          raise StandardError, "The '#{per_param}' module you used is unknown.\nYou can use: `location`, `security`, `timezone`, `currency`, and/or `device`."
        end
      end

      #? Validate the lang variable
      if !AVAILABLE_LANGUAGES.include?(lang)
        raise StandardError, "The `lang` option value '#{lang}' you specified is unknown.\nYou can use: `EN`, `AR`, `DE`, `FR`, `ES`, `JA`, `ZH`, or `RU`."
      end

      #? Validate the mode variable
      if mode != "live" && mode != "test"
        raise StandardError, "The `mode` option value '#{mode}' you specified is unknown.\nYou can use: `live` or `test`."
      end

      url = URI(BASE_URL + "/IPLookup?ip=#{ip}&params=#{params.join(',')}&format=JSON&lang=#{lang}&mode=#{mode}&source=Ruby-Gem")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Get.new(url)
      request['Authorization'] = "Bearer #{@token}"

      response = http.request(request)

      if response.code == '200'
        parsed_response = JSON.parse(response.body)
        if parsed_response['status'] == 'success'
            OpenStruct.new(parsed_response['data'])
        else
            raise StandardError, "Error: #{parsed_response['description']}"
        end
      else
        raise StandardError, "Error: #{response.code} - #{response.message}"
      end
    end

    def bulk_lookup(options)
      ips = options[:ips] || []
      params = options[:params] || []
      lang = (options[:lang] || "EN").upcase
      mode = options[:mode] || "live".downcase

      ips = [] unless ips.is_a?(Array)

      # Validate the ips variable
      if ips.empty?
        raise StandardError, "You should pass the `ips` parameter."
      end

      ips.each do |ip|
        if ip.length < 7
          raise StandardError, "You should pass a valid IP Addresses in the `ips` parameter."
        end
      end

      # Validate the params variable items
      params.each do |param|
        if param.length > 0 && !AVAILABLE_GEOIP_PARAMS.include?(param)
          raise StandardError, "The '#{param}' module you used is unknown.\nYou can use: `location`, `security`, `timezone`, `currency`, and/or `device`."
        end
      end

      # Validate the lang variable
      if !AVAILABLE_LANGUAGES.include?(lang)
        raise StandardError, "The `lang` option value '#{lang}' you specified is unknown.\nYou can use: `EN`, `AR`, `DE`, `FR`, `ES`, `JA`, `ZH`, or `RU`."
      end

      # Validate the mode variable
      if mode != "live" && mode != "test"
        raise StandardError, "The `mode` option value '#{mode}' you specified is unknown.\nYou can use: `live` or `test`."
      end

      url = URI("#{BASE_URL}/BulkLookup?ips=#{ips.join(',')}&params=#{params.join(',')}&format=JSON&lang=#{lang}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Get.new(url)
      request['Authorization'] = "Bearer #{@token}"

      response = http.request(request)

      if response.code == '200'
        parsed_response = JSON.parse(response.body)
        if parsed_response['status'] == 'success'
          OpenStruct.new(parsed_response['data'])
        else
          raise StandardError, "Error: #{parsed_response['description']}"
        end
      else
        raise StandardError, "Error: #{response.code} - #{response.message}"
      end
    end

    def country(options)
      country_code = options[:countryCode] || ""
      params = options[:params] || []
      lang = (options[:lang] || "EN").upcase
      mode = options[:mode] || "live".downcase

      # Validate the params variable items
      params.each do |param|
        if param.length > 0 && !AVAILABLE_COUNTRY_PARAMS.include?(param)
          raise StandardError, "The '#{param}' module you used is unknown.\nYou can use: `language`, `flag`, `currency`, and/or `timezone`.\nRead more at: https://docs.greip.io/api-reference/endpoint/other-services/country-data"
        end
      end

      # Validate the lang variable
      if !AVAILABLE_LANGUAGES.include?(lang)
        raise StandardError, "The `lang` option value '#{lang}' you specified is unknown.\nYou can use: `EN`, `AR`, `DE`, `FR`, `ES`, `JA`, `ZH`, or `RU`.\nRead more at: https://docs.greip.io/api-reference/endpoint/other-services/country-data"
      end

      # Validate the mode variable
      if mode != "live" && mode != "test"
        raise StandardError, "The `mode` option value '#{mode}' you specified is unknown.\nYou can use: `live` or `test`.\nRead more at: https://docs.greip.io/api-reference/endpoint/other-services/country-data"
      end

      url = URI("#{BASE_URL}/Country?CountryCode=#{country_code}&params=#{params.join(',')}&format=JSON&lang=#{lang}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Get.new(url)
      request['Authorization'] = "Bearer #{@token}"

      response = http.request(request)

      if response.code == '200'
        parsed_response = JSON.parse(response.body)
        if parsed_response['status'] == 'success'
          OpenStruct.new(parsed_response['data'])
        else
          raise StandardError, "Error: #{parsed_response['description']}"
        end
      else
        raise StandardError, "Error: #{response.code} - #{response.message}"
      end
    end

    def profanity(options)
      text = options[:text] || ""
      params = options[:params] || []
      lang = (options[:lang] || "EN").upcase
      mode = options[:mode] || "live".downcase

      # Validate the text variable
      if text.length < 1
        raise StandardError, "You should pass the `text` parameter."
      end

      # Validate the lang variable
      if !AVAILABLE_LANGUAGES.include?(lang)
        raise StandardError, "The `lang` option value '#{lang}' you specified is unknown.\nYou can use: `EN`, `AR`, `DE`, `FR`, `ES`, `JA`, `ZH`, or `RU`.\nRead more at: https://docs.greip.io/api-reference/endpoint/other-services/profanity-detection"
      end

      # Validate the mode variable
      if mode != "live" && mode != "test"
        raise StandardError, "The `mode` option value '#{mode}' you specified is unknown.\nYou can use: `live` or `test`.\nRead more at: https://docs.greip.io/api-reference/endpoint/other-services/profanity-detection"
      end

      url = URI("#{BASE_URL}/badWords?text=#{text}&params=#{params.join(',')}&format=JSON&lang=#{lang}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Get.new(url)
      request['Authorization'] = "Bearer #{@token}"

      response = http.request(request)

      if response.code == '200'
        parsed_response = JSON.parse(response.body)
        if parsed_response['status'] == 'success'
          OpenStruct.new(parsed_response['data'])
        else
          raise StandardError, "Error: #{parsed_response['description']}"
        end
      else
        raise StandardError, "Error: #{response.code} - #{response.message}"
      end
    end

    def asn(options)
      asn = options[:asn] || "".upcase
      mode = options[:mode] || "live".downcase

      # Validate the asn variable
      if asn.length < 1
        raise StandardError, "You should pass the `asn` parameter."
      end

      # Validate the mode variable
      if mode != "live" && mode != "test"
        raise StandardError, "The `mode` option value '#{mode}' you specified is unknown.\nYou can use: `live` or `test`.\nRead more at: https://docs.greip.io/api-reference/endpoint/ip-geolocation/asn-lookup"
      end

      url = URI("#{BASE_URL}/ASNLookup?asn=#{asn}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Get.new(url)
      request['Authorization'] = "Bearer #{@token}"

      response = http.request(request)

      if response.code == '200'
        parsed_response = JSON.parse(response.body)
        if parsed_response['status'] == 'success'
          OpenStruct.new(parsed_response['data'])
        else
          raise StandardError, "Error: #{parsed_response['description']}"
        end
      else
        raise StandardError, "Error: #{response.code} - #{response.message}"
      end
    end

    def email_validation(options)
      email = options[:email] || "".downcase
      mode = options[:mode] || "live".downcase

      # Validate the email variable
      if email.length < 1
        raise StandardError, "You should pass the `email` parameter."
      end

      # Validate the mode variable
      if mode != "live" && mode != "test"
        raise StandardError, "The `mode` option value '#{mode}' you specified is unknown.\nYou can use: `live` or `test`.\nRead more at: https://docs.greip.io/api-reference/endpoint/data-validation/email-lookup"
      end

      url = URI("#{BASE_URL}/validateEmail?email=#{email}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Get.new(url)
      request['Authorization'] = "Bearer #{@token}"

      response = http.request(request)

      if response.code == '200'
        parsed_response = JSON.parse(response.body)
        if parsed_response['status'] == 'success'
          OpenStruct.new(parsed_response['data'])
        else
          raise StandardError, "Error: #{parsed_response['description']}"
        end
      else
        raise StandardError, "Error: #{response.code} - #{response.message}"
      end
    end

    def phone_validation(options)
      phone = options[:phone] || ""
      country_code = options[:countryCode] || "".upcase
      mode = options[:mode] || "live".downcase

      # Validate the phone and countryCode variables
      if phone.length < 1 || country_code.length < 1
        raise StandardError, "You should pass both `phone` and `countryCode` parameters."
      end

      # Validate the mode variable
      if mode != "live" && mode != "test"
        raise StandardError, "The `mode` option value '#{mode}' you specified is unknown.\nYou can use: `live` or `test`.\nRead more at: https://docs.greip.io/api-reference/endpoint/data-validation/phone-lookup"
      end

      url = URI("#{BASE_URL}/validatePhone?phone=#{phone}&countryCode=#{country_code}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Get.new(url)
      request['Authorization'] = "Bearer #{@token}"

      response = http.request(request)

      if response.code == '200'
        parsed_response = JSON.parse(response.body)
        if parsed_response['status'] == 'success'
          OpenStruct.new(parsed_response['data'])
        else
          raise StandardError, "Error: #{parsed_response['description']}"
        end
      else
        raise StandardError, "Error: #{response.code} - #{response.message}"
      end
    end

    def iban_validation(options)
      iban = options[:iban] || "".upcase
      mode = options[:mode] || "live".downcase

      # Validate the iban variable
      if iban.length < 1
        raise StandardError, "You should pass the `iban` parameter."
      end

      # Validate the mode variable
      if mode != "live" && mode != "test"
        raise StandardError, "The `mode` option value '#{mode}' you specified is unknown.\nYou can use: `live` or `test`.\nRead more at: https://docs.greip.io/api-reference/endpoint/payment-fraud/iban-validation"
      end

      url = URI("#{BASE_URL}/validateIBAN?iban=#{iban}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Get.new(url)
      request['Authorization'] = "Bearer #{@token}"

      response = http.request(request)

      if response.code == '200'
        parsed_response = JSON.parse(response.body)
        if parsed_response['status'] == 'success'
          OpenStruct.new(parsed_response['data'])
        else
          raise StandardError, "Error: #{parsed_response['description']}"
        end
      else
        raise StandardError, "Error: #{response.code} - #{response.message}"
      end
    end

    def payment_fraud(options)
      data = options[:data] || []
      mode = options[:mode] || "live".downcase

      # Validate the data variable
      if !data.is_a?(Hash) || data.empty?
        raise StandardError, "You should pass the `data` parameter."
      end

      # Validate the mode variable
      if mode != "live" && mode != "test"
        raise StandardError, "The `mode` option value '#{mode}' you specified is unknown.\nYou can use: `live` or `test`.\nRead more at: https://docs.greip.io/api-reference/endpoint/payment-fraud/payment-fraud-prevention"
      end

      url = URI("#{BASE_URL}/paymentFraud")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Post.new(url)
      request['Content-Type'] = 'application/json'
      request['Authorization'] = "Bearer #{@token}"
      request.body = data.to_json

      response = http.request(request)

      if response.code == '200'
        parsed_response = JSON.parse(response.body)
        if parsed_response['status'] == 'success'
          OpenStruct.new(parsed_response['data'])
        else
          raise StandardError, "Error: #{parsed_response['description']}"
        end
      else
        raise StandardError, "Error: #{response.code} - #{response.message}"
      end
    end

  end

  def self.create(token)
    GreipHandler.new(token)
  end
end

access_token = '0540759999851b6b25e98cbfae03c94e'
handler = Greip::create(access_token)
data = handler.lookup({ ip: "1.1.1.1", params: ["security", "timezone", "currency"], lang: "EN", mode: "live" })

puts data
