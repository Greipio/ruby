# frozen_string_literal: true

module ErrorMessages
  MODE = "The `mode` option value you specified is unknown.\n" \
  "You can use: `live` or `test`.\nRead more at: " \
  'https://docs.greip.io/api-reference/endpoint/payment-fraud/payment-fraud-prevention'

  DATA = 'You should pass the `data` parameter.'

  COUNTRY_CODE_PHONE = 'You should pass both `phone` and `countryCode` parameters.'

  IP = 'You should pass the `ip` parameter.'

  IPS = 'You should pass the `ips` parameter.'

  VALID_IPS = 'You should pass a valid IP Addresses in the `ips` parameter.'

  LANG = "The `lang` option value you specified is unknown.\n" \
  'You can use: `EN`, `AR`, `DE`, `FR`, `ES`, `JA`, `ZH`, or `RU`.'

  TEXT = 'You should pass the `text` parameter.'

  ASN = 'You should pass the `asn` parameter.'

  EMAIL = 'You should pass the `email` parameter.'
end
