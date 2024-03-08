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
![API Status](https://img.shields.io/website?down_color=orange&down_message=down&label=API%20status&up_color=green&up_message=up&url=https%3A%2F%2Fgregeoip.com)

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

Here's how you use the methods:

### 1. IP Lookup Method

```ruby
require 'greip'

access_token = 'your-api-key-goes-here'
handler = greip::create(access_token)
data = handler.lookup({ ip: "1.1.1.1", params: ["security", "timezone", "currency"], lang: "EN", mode: "live" })

puts data

```

### 2. Bulk IP Lookup Method

```javascript
const { Greip } = require("greip-node");

let greip = new Greip(process.env.YOUR_GREIP_TOKEN);

greip
  .BulkLookup({
    ips: ["1.1.1.1", "2.2.2.2"],
  })
  .then((res: any) => {
    console.log(res.data); // Log Response
  })
  .catch((error: any) => {
    console.log(error);
  });
```

### 3. ASN Lookup Method

```javascript
const { Greip } = require("greip-node");

let greip = new Greip(process.env.YOUR_GREIP_TOKEN);

greip
  .ASN({
    asn: "AS01",
  })
  .then((res: any) => {
    console.log(res.data); // Log Response
  })
  .catch((error: any) => {
    console.log(error);
  });
```

### 4. Profanity Detection Method

```javascript
const { Greip } = require("greip-node");

let greip = new Greip(process.env.YOUR_GREIP_TOKEN);

greip
  .Profanity({
    text: "This is just normal sample text.",
  })
  .then((res: any) => {
    console.log(res.data); // Log Response
  })
  .catch((error: any) => {
    console.log(error);
  });
```

### 5. Country Lookup Method

```javascript
const { Greip } = require("greip-node");

let greip = new Greip(process.env.YOUR_GREIP_TOKEN);

greip
  .Country({
    countryCode: "SA",
  })
  .then((res: any) => {
    console.log(res.data); // Log Response
  })
  .catch((error: any) => {
    console.log(error);
  });
```

### 6. Email Validation Method

```javascript
const { Greip } = require("greip-node");

let greip = new Greip(process.env.YOUR_GREIP_TOKEN);

greip
  .EmailValidation({
    email: "name@domain.com",
  })
  .then((res: any) => {
    console.log(res.data); // Log Response
  })
  .catch((error: any) => {
    console.log(error);
  });
```

### 7. Phone Validation Method

```javascript
const { Greip } = require("greip-node");

let greip = new Greip(process.env.YOUR_GREIP_TOKEN);

greip
  .PhoneValidation({
    phone: "123123123",
    countryCode: "US",
  })
  .then((res: any) => {
    console.log(res.data); // Log Response
  })
  .catch((error: any) => {
    console.log(error);
  });
```

### 8. Payment Fraud Prevention Method

```javascript
const { Greip } = require("greip-node");

let greip = new Greip(process.env.YOUR_GREIP_TOKEN);

greip
  .PaymentFraud({
    data: {
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
    },
  })
  .then((res: any) => {
    console.log(res.data); // Log Response
  })
  .catch((error: any) => {
    console.log(error);
  });
```

### 9. IBAN Validation Method

```javascript
const { Greip } = require("greip-node");

let greip = new Greip(process.env.YOUR_GREIP_TOKEN);

greip
  .IBANValidation({
    iban: "BY86AKBB10100000002966000000",
  })
  .then((res: any) => {
    console.log(res); // Log Response
  })
  .catch((error: any) => {
    console.log(error);
  });
```

## Options, Methods and More

You can find the full guide of this package by visiting our
[Documentation Page](https://docs.greip.io/).

## Credits

- [Greip Developers](https://greip.io)
- [All Contributors](https://github.com/Greipio/node/graphs/contributors)