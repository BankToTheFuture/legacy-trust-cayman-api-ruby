# LegacyTrust API Wrapper in Ruby

This gem allows you to integrate your Ruby application with LegacyTrust API based on OAuth2.

Read [Legacy Trust API documentation](https://partner-api.smarttrust.welton.ee/swagger/index.html?url=/swagger/partner-api/swagger.json) for more details.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'legacy-trust-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install legacy-trust-api

## Usage

Setup OAuth2 credentials `client_id` and `client_secret` before your first use.

Example:
```ruby
require 'legacy_trust'

LegacyTrust.client_id = 'your-client-id'
Legacytrust.client_secret = 'your-client-secret'

LegacyTrust::Currency.fetch_all(params: { currency_class: 'Fiat' })
```

gives the following result:

```
#<LegacyTrust::Result:0x00007fa112205c50
 @body=
  [{:symbol=>"AUD", :name=>"Australian Dollar", :class=>"Fiat", :decimal_places=>2},
   {:symbol=>"CAD", :name=>"Canadian Dollar", :class=>"Fiat", :decimal_places=>2},
   {:symbol=>"EUR", :name=>"Euro", :class=>"Fiat", :decimal_places=>2},
   {:symbol=>"GBP", :name=>"Pound sterling", :class=>"Fiat", :decimal_places=>2},
   {:symbol=>"HKD", :name=>"HK Dollar", :class=>"Fiat", :decimal_places=>2},
   {:symbol=>"TYTYYY", :name=>"ttyjnljnlnknjjk jk kj lj jk j k l ", :class=>"Fiat", :decimal_places=>2},
   {:symbol=>"USD", :name=>"US Dollar", :class=>"Fiat", :decimal_places=>2}],
 @status=200>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/legacy-trust-api-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
