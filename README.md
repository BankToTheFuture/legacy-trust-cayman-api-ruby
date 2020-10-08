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

### OAuth2 authentication
Setup OAuth2 credentials `oauth_client_id` and `oauth_client_secret` before your first use. These are mandatory to establish authentication with LegacyTrust API. In case these keys are missing or invalid, you should get `LegacyTrust::SetupError`.

Example:
```ruby
require 'legacy_trust'

LegacyTrust.oauth_client_id = 'your-client-id'
Legacytrust.oauth_client_secret = 'your-client-secret'

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

### Global API settings
In case that your API integration is not based on multiple client ids or service account ids, there is an option to set up `global_client_id` and `global_service_account_id` so there is no need to attach them to each API request execution.

Example:
```ruby
require 'legacy_trust'

LegacyTrust.global_client_id = 'your-client-id'
Legacytrust.global_service_account_id = 'your-service-account-id'

LegacyTrust::Instruction::FiatDeposit.create(body: { client_bank_account_id: 36, amount: 100.5 })
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/BankToTheFuture/legacy-trust-api-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
