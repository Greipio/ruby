# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/ClassLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Style/NegatedIf

require_relative "greip/version"
require_relative "greip/constants"
require_relative "greip/error_messages"

require "json"
require "net/http"
require "uri"

# Greip module
module Greip
  class Error < StandardError; end

  # GreipHandler class
  class GreipHandler
    def initialize(token)
      @token = token
    end

    def lookup(options)
      ip = options[:ip] || ""
      params = options[:params] || []
      lang = (options[:lang] || "EN").upcase
      mode = (options[:mode] || "live").downcase

      # Validate the ip variable
      raise StandardError, ErrorMessages::IP unless ip.length > 5

      # Validate the params variable items
      params.each do |per_param|
        if !per_param.empty? && !AVAILABLE_GEOIP_PARAMS.include?(per_param)
          raise StandardError, "The '#{per_param}' module you used is unknown.\n" \
                               "You can use: `location`, `security`, `timezone`, `currency`, and/or `device`."
        end
      end

      # Validate the lang variable
      !AVAILABLE_LANGUAGES.include?(lang) && (raise StandardError, ErrorMessages::LANG)

      # Validate the mode variable
      mode != "live" && mode != "test" && (raise StandardError, ErrorMessages::MODE)

      url = URI(BASE_URL + "/IPLookup?ip=#{ip}&params=#{params.join(",")}&lang=#{lang}&mode=#{mode}&source=Ruby-Gem")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == "https")

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{@token}"

      response = http.request(request)

      raise StandardError, "Error: #{response.code} - #{response.message}" unless response.code == "200"

      parsed_response = JSON.parse(response.body)

      raise StandardError, "Error: #{parsed_response["description"]}" unless parsed_response["status"] == "success"

      parsed_response["data"]
    end

    def bulk_lookup(options)
      ips = options[:ips] || []
      params = options[:params] || []
      lang = (options[:lang] || "EN").upcase
      mode = (options[:mode] || "live").downcase

      ips = [] unless ips.is_a?(Array)

      # Validate the ips variable
      raise StandardError, ErrorMessages::IPS if ips.empty?

      ips.each do |ip|
        raise StandardError, ErrorMessages::VALID_IPS if ip.length < 7
      end

      # Validate the params variable items
      params.each do |param|
        if !param.empty? && !AVAILABLE_GEOIP_PARAMS.include?(param)
          raise StandardError, "The '#{param}' module you used is unknown.\n" \
                               "You can use: `location`, `security`, `timezone`, `currency`, and/or `device`."
        end
      end

      # Validate the lang variable
      !AVAILABLE_LANGUAGES.include?(lang) && (raise StandardError, ErrorMessages::LANG)

      # Validate the mode variable
      mode != "live" && mode != "test" && (raise StandardError, ErrorMessages::MODE)

      url = URI("#{BASE_URL}/BulkLookup?ips=#{ips.join(",")}&params=#{params.join(",")}&lang=#{lang}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == "https")

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{@token}"

      response = http.request(request)

      raise StandardError, "Error: #{response.code} - #{response.message}" unless response.code == "200"

      parsed_response = JSON.parse(response.body)

      raise StandardError, "Error: #{parsed_response["description"]}" unless parsed_response["status"] == "success"

      parsed_response["data"]
    end

    def country(options)
      country_code = options[:countryCode] || ""
      params = options[:params] || []
      lang = (options[:lang] || "EN").upcase
      mode = (options[:mode] || "live").downcase

      # Validate the params variable items
      params.each do |param|
        next unless param.empty? || !AVAILABLE_COUNTRY_PARAMS.include?(param)

        raise StandardError, "The '#{param}' module you used is unknown.\n" \
                             "You can use: `language`, `flag`, `currency`, and/or `timezone`.\n" \
                             "Read more at: https://docs.greip.io/api-reference/endpoint/other-services/country-data"
      end

      # Validate the lang variable
      raise StandardError, ErrorMessages::LANG if !AVAILABLE_LANGUAGES.include?(lang)

      # Validate the mode variable
      mode != "live" && mode != "test" && (raise StandardError, ErrorMessages::MODE)

      url = URI("#{BASE_URL}/Country?CountryCode=#{country_code}&params=#{params.join(",")}&lang=#{lang}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == "https")

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{@token}"

      response = http.request(request)

      raise StandardError, "Error: #{response.code} - #{response.message}" unless response.code == "200"

      parsed_response = JSON.parse(response.body)

      raise StandardError, "Error: #{parsed_response["description"]}" unless parsed_response["status"] == "success"

      parsed_response["data"]
    end

    def profanity(options)
      text = options[:text] || ""
      params = options[:params] || []
      lang = (options[:lang] || "EN").upcase
      mode = (options[:mode] || "live").downcase

      # Validate the text variable
      raise StandardError, ErrorMessages::TEXT if text.empty?

      # Validate the lang variable
      raise StandardError, ErrorMessages::LANG if !AVAILABLE_LANGUAGES.include?(lang)

      # Validate the mode variable
      mode != "live" && mode != "test" && (raise StandardError, ErrorMessages::MODE)

      url = URI("#{BASE_URL}/badWords?text=#{text}&params=#{params.join(",")}&format=JSON&lang=#{lang}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == "https")

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{@token}"

      response = http.request(request)

      raise StandardError, "Error: #{response.code} - #{response.message}" unless response.code == "200"

      parsed_response = JSON.parse(response.body)

      raise StandardError, "Error: #{parsed_response["description"]}" unless parsed_response["status"] == "success"

      parsed_response["data"]
    end

    def asn(options)
      asn = (options[:asn] || "").upcase
      mode = (options[:mode] || "live").downcase

      # Validate the asn variable
      raise StandardError, ErrorMessages::ASN if asn.empty?

      # Validate the mode variable
      mode != "live" && mode != "test" && (raise StandardError, ErrorMessages::MODE)

      url = URI("#{BASE_URL}/ASNLookup?asn=#{asn}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == "https")

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{@token}"

      response = http.request(request)

      raise StandardError, "Error: #{response.code} - #{response.message}" unless response.code == "200"

      parsed_response = JSON.parse(response.body)

      raise StandardError, "Error: #{parsed_response["description"]}" unless parsed_response["status"] == "success"

      parsed_response["data"]
    end

    def email_validation(options)
      email = (options[:email] || "").downcase
      mode = (options[:mode] || "live").downcase

      # Validate the email variable
      raise StandardError, ErrorMessages::EMAIL if email.empty?

      # Validate the mode variable
      mode != "live" && mode != "test" && (raise StandardError, ErrorMessages::MODE)

      url = URI("#{BASE_URL}/validateEmail?email=#{email}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == "https")

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{@token}"

      response = http.request(request)

      raise StandardError, "Error: #{response.code} - #{response.message}" unless response.code == "200"

      parsed_response = JSON.parse(response.body)

      raise StandardError, "Error: #{parsed_response["description"]}" unless parsed_response["status"] == "success"

      parsed_response["data"]
    end

    def phone_validation(options)
      phone = options[:phone] || ""
      country_code = (options[:countryCode] || "").upcase
      mode = (options[:mode] || "live").downcase

      # Validate the phone and countryCode variables
      (phone.empty? || country_code.empty?) && (raise StandardError, ErrorMessages::COUNTRY_CODE_PHONE)

      # Validate the mode variable
      mode != "live" && mode != "test" && (raise StandardError, ErrorMessages::MODE)

      url = URI("#{BASE_URL}/validatePhone?phone=#{phone}&countryCode=#{country_code}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == "https")

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{@token}"

      response = http.request(request)

      raise StandardError, "Error: #{response.code} - #{response.message}" unless response.code == "200"

      parsed_response = JSON.parse(response.body)

      raise StandardError, "Error: #{parsed_response["description"]}" unless parsed_response["status"] == "success"

      parsed_response["data"]
    end

    def iban_validation(options)
      iban = (options[:iban] || "").upcase
      mode = (options[:mode] || "live").downcase

      # Validate the iban variable
      raise StandardError, "You should pass the `iban` parameter." if iban.empty?

      # Validate the mode variable
      mode != "live" && mode != "test" && (raise StandardError, ErrorMessages::MODE)

      url = URI("#{BASE_URL}/validateIBAN?iban=#{iban}&mode=#{mode}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == "https")

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{@token}"

      response = http.request(request)

      raise StandardError, "Error: #{response.code} - #{response.message}" unless response.code == "200"

      parsed_response = JSON.parse(response.body)

      raise StandardError, "Error: #{parsed_response["description"]}" unless parsed_response["status"] == "success"

      parsed_response["data"]
    end

    def payment_fraud(options)
      data = options[:data] || []
      mode = (options[:mode] || "live").downcase

      # Validate the mode variable
      raise StandardError, ErrorMessages::MODE unless %w[live test].include?(mode)

      # Validate the data variable
      raise StandardError, ErrorMessages::DATA unless data.is_a?(Hash) && !data.empty?

      url = URI("#{BASE_URL}/paymentFraud")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == "https")

      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{@token}"
      request.body = data.to_json

      response = http.request(request)

      raise StandardError, "Error: #{response.code} - #{response.message}" unless response.code == "200"

      parsed_response = JSON.parse(response.body)
      raise StandardError, "Error: #{parsed_response["description"]}" unless parsed_response["status"] == "success"

      parsed_response["data"]
    end
  end

  def self.create(token)
    GreipHandler.new(token)
  end
end

# rubocop:enable Style/NegatedIf
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/ClassLength
# rubocop:enable Metrics/AbcSize
