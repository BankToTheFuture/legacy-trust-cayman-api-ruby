# LegacyTrustCayman API Wrapper in Ruby

This gem allows you to integrate your Ruby application with LegacyTrustCayman API based on OAuth2.

Read [Legacy Trust API documentation](https://partner-api.1stdigital.com/swagger/index.html) for more details.

If you can't find something in their official documentation then check their [staging documentation](https://partner-api-aggregator-dev.k8s.smarttrust.app/swagger/index.html?url=/swagger/partner-api/swagger.json). Perhaps your are looking for stuff that has not been released yet.

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
Setup OAuth2 credentials `oauth_client_id` and `oauth_client_secret` before your first use. These are mandatory to establish authentication with LegacyTrustCayman API. In case these keys are missing or invalid, you should get `LegacyTrustCayman::SetupError`.

Example:
```ruby
require 'legacy_trust'

LegacyTrustCayman.oauth_client_id = 'your-client-id'
LegacyTrustCayman.oauth_client_secret = 'your-client-secret'

LegacyTrustCayman::Currency.fetch_all(params: { currency_class: 'Fiat' })
```

gives the following result:

```
#<LegacyTrustCayman::Result:0x00007fa112205c50
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

### Sandbox mode
If you wish to use staging servers for testing purposes you can set `LegacyTrustCayman.sandbox_mode` (`false` by default) as follows:

```ruby
require 'legacy_trust'

LegacyTrustCayman.sandbox_mode = true

# Use any method to be executed on staging environment
```

### Global API settings
In case that your API integration is not based on multiple client ids or service account ids, there is an option to set up `global_client_id` and `global_service_account_id` so there is no need to attach them to each API request execution.

Example:
```ruby
require 'legacy_trust'

LegacyTrustCayman.global_client_id = 'your-client-id'
LegacyTrustCayman.global_service_account_id = 'your-service-account-id'

LegacyTrustCayman::Instruction::FiatDeposit.create(body: { client_bank_account_id: 36, amount: 100.5 })
```

### Using Proxy
If you wish to execute requests through proxy use `LegacyTrustCayman.proxy` (`nil` by default) as follows:

```ruby
require 'legacy_trust'

LegacyTrustCayman.proxy = 'PROXY_URL'

# Use any method to be executed using proxy
```

Proxy is used to perform API requests as well as fetching OAuth token.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/BankToTheFuture/legacy-trust-api-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
