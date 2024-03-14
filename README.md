# Greip Ruby Gem

The official Ruby Gem of Greip API

[Report Issue](https://github.com/Greipio/ruby/issues/new) ·
[Request Feature](https://github.com/Greipio/ruby/discussions/new?category=ideas)
· [Greip Website](https://greip.io/) · [Documentation](https://docs.greip.io/)

[![Ruby Gem of Greip](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)](https://rubygems.org/gems/greip)
[![Github Repository](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Greipio/ruby)

![Gem version](https://img.shields.io/gem/v/greip)
&nbsp;
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/Greipio/ruby?color=green&label=Minified%20size&logo=github)
&nbsp;
[![License: MIT](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/license/apache-2-0)
&nbsp;
![API Status](https://img.shields.io/website?down_color=orange&down_message=down&label=API%20status&up_color=green&up_message=up&url=https%3A%2F%greipapi.com)

---

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'greip'
```

Then run the following command in your terminal:

```bash
bundle install
```

Or, install it with the following command:

```bash
gem install greip
```

## Usage

Here's how you can use the Greip Gem in your Ruby project:

### 1. IP Lookup Method

Use this method to retrieve the information of a given IP address.

```ruby
require 'greip'

access_token = 'your-api-key-goes-here'
handler = Greip.create(access_token)
data = handler.lookup({ ip: "1.1.1.1", params: ["security", "timezone", "currency"], lang: "EN", mode: "live" })

puts data

```

### 2. IP Threats Method

Use this method to retrieve threat intelligence information associated with a given IP address.

```ruby
require 'greip'

access_token = 'your-api-key-goes-here'
handler = Greip.create(access_token)
data = handler.threats({ ip: "1.1.1.1", mode: "live" })

puts data

```

### 3. Bulk IP Lookup Method

You can use this method to retrieve the information of multiple IP addresses (no need to use the Lookup method inside a loop).

```ruby
require 'greip'

access_token = 'your-api-key-goes-here'
handler = Greip.create(access_token)

data = handler.bulk_lookup({ ips: ["1.1.1.1", "2.2.2.2"], params: ["security", "timezone", "currency"], lang: "EN", mode: "live" })

puts data
```

### 4. ASN Lookup Method

In this method, Greip will help you lookup any given AS Number and returning all data related to it, like: name, org (the organization name), country, domain, email, phone, totalIPs, list of all routes (v4 & v6) related the given AS Number, etc.

```ruby
require 'greip'

access_token = 'your-api-key-goes-here'
handler = Greip.create(access_token)

data = handler.asn({ asn: "AS01", mode: "live" })

puts data
```

### 5. Profanity Detection Method

This method can be used to detect abuse of your website/app. It’s a great way to know more about your user inputs and whether they contain profanity (bad words) or not before releasing them to the public.

```ruby
require 'greip'

access_token = 'your-api-key-goes-here'
handler = Greip.create(access_token)

data = handler.profanity({ text: "This is just a normal text", lang: "EN", mode: "live" })

puts data
```

### 6. Country Lookup Method

This method can help you retrieve information of the given country.

```ruby
require 'greip'

access_token = 'your-api-key-goes-here'
handler = Greip.create(access_token)

data = handler.country({ countryCode: "PS", params: ["timezone", "currency"], lang: "EN", mode: "live" })

puts data
```

### 7. Email Validation Method

This method provides an additional layer of validation for your system. While validating email syntax is important, it is not sufficient.

```ruby
require 'greip'

access_token = 'your-api-key-goes-here'
handler = Greip.create(access_token)

data = handler.email_validation({ email: "name@domain.com", mode: "live" })

puts data
```

### 8. Phone Validation Method

This method can be used as an extra-layer of your system for validating phone numbers. It validates phone number syntax and valid-possibility.

```ruby
require 'greip'

access_token = 'your-api-key-goes-here'
handler = Greip.create(access_token)

data = handler.phone_validation({ phone: "1234567890", countryCode: "TR", mode: "live" })

puts data
```

### 9. Payment Fraud Prevention Method

Prevent financial losses by deploying AI-Powered modules.

```ruby
require 'greip'

access_token = 'your-api-key-goes-here'
handler = Greip.create(access_token)

payload = {
  action: "purchase",
  website_domain: "",
  website_name: "",
  merchant_id: 21,
  shipment_id: 1,
  transaction_id: 100,
  transaction_amount: 1000000,
  transaction_currency: "GBP",
  cart_items: {
    item_id: 1,
    item_name: "Product name",
    item_quantity: 1,
    item_price: "1100.55",
    item_category_id: 1,
  },
  isDigitalProducts: true,
  coupon: "ASDF",
  customer_id: 1,
  customer_firstname: "First",
  customer_lastname: "Last",
  customer_pob: "London",
  customer_ip: "1.1.1.1",
  customer_country: "GB",
  customer_region: "London",
  customer_city: "London",
  customer_zip: "NW10 7PQ",
  customer_street: "7 Coronation Road",
  customer_street2: "",
  customer_latitude: 0.123,
  customer_longitude: 0.123,
  customer_device_id: "UNIQUE_DEVICE_ID",
  customer_phone: "000000000",
  customer_registration_date: 1677554670,
  customer_balance: "1000.00",
  customer_dob: "1997-19-05",
  customer_email: "name@domain.com",
  customer_2fa: true,
  customer_useragent: "Mozill almaden sdfwer",
  shipping_country: "GB",
  shipping_region: "London",
  shipping_city: "London",
  shipping_zip: "NW10 7PQ",
  shipping_street: "7 Coronation Road",
  shipping_street2: "",
  shipping_latitude: 0.123,
  shipping_longitude: 0.123,
  billing_country: "GB",
  billing_region: "London",
  billing_city: "London",
  billing_zip: "NW10 7PQ",
  billing_street: "7 Coronation Road",
  billing_street2: "",
  billing_latitude: 0.123,
  billing_longitude: 0.123,
  payment_type: "applepay",
  card_name: "First Last",
  card_number: "1234XXXXXXXX1234",
  card_expiry: "29/05",
  cvv_result: true,
}

data = handler.payment_fraud({ data: payload })

puts data
```

### 10. IBAN Validation Method

This method allows you to validate International Bank Account Numbers (IBANs) and retrieve additional information about the country associated with the IBAN.

```ruby
require 'greip'

access_token = 'your-api-key-goes-here'
handler = Greip.create(access_token)

data = handler.iban_validation({ iban: "BY86AKBB10100000002966000000" })

puts data
```

## Options, Methods and More

You can find the full guide of this package by visiting our
[Documentation Page](https://docs.greip.io/).

## Credits

- [Greip Developers](https://greip.io)
- [All Contributors](https://github.com/Greipio/ruby/graphs/contributors)
