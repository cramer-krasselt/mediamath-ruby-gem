# MediaMath Unofficial gem
Quick hack on the Instagram Gem, adapted for the MediaMath.

Not endpoint-complete by a far cry, not even tested at all.

This works for my purposes currently, but is obviously a use-at-own-risk piece of software.

## Usage

```ruby
require 'mediamath'

MediaMathAPI.configure do |config|
  config.user = ENV['MM_USER']
  config.password = ENV['MM_PASSWORD']
  config.api_key = ENV['MM_API_KEY']
  config.organization = ENV['MM_ORGANIZATION']
  config.api_secret = ENV['MM_API_SECRET']
end

# Cookie Auth
res = MediaMathAPI.get_access_cookie
#<Hashie::Mash ... >
MediaMathAPI.cookie = res.session.sessionid

# OAuth2
# First leg
MediaMathAPI.code = MediaMathAPI.get_access_code
#"111112222223333"

# Second leg
res = MediaMathAPI.get_access_token
#<Hashie::Mash ... >

MediaMathAPI.access_token = res.access_token
MediaMathAPI.refresh_token = res.refresh_token
MediaMathAPI.access_token_expiry = Time.now + res.expires_in

client = MediaMathAPI::Client.new
#<MediaMathAPI::Client ... >

client.campaigns
#<Hashie::Mash ... >
```
