module Greip
    BASE_URL = 'https://gregeoip.com'.freeze
  
    AVAILABLE_LANGUAGES = ['EN', 'AR', 'DE', 'FR', 'ES', 'JA', 'ZH', 'RU'].freeze
    AVAILABLE_GEOIP_PARAMS = [
      'location', 'security', 'timezone', 'currency', 'device'
    ].freeze
end