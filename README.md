# xing

Ruby wrapper for the [Xing API](https://dev.xing.com).

## Supported Rubies

Currently, only Ruby 2.0 is supported.

## Installation

    [sudo] gem install xing

## Usage

### Authenticate

Xing's API uses Oauth for authentication. Luckily, the Xing gem hides most of the gory details from you.

    require 'rubygems'
    require 'xing'

    # Visit the [XING Developer Portal](https://dev.xing.com/applications) to get your API keys.
    client = Xing::Client.new(:consumer_key => 'your_consumer_key', :consumer_secret => 'your_consumer_secret')
    rtoken = client.request_token.token
    rsecret = client.request_token.secret

    # to test from your desktop, open the following url in your browser
    # and record the pin it gives you
    client.request_token.authorize_url
    => "https://api.xing.com/v1/authorize?oauth_token=<generated_token>"

    # then fetch your access keys
    client.authorize_from_request(rtoken, rsecret, pin)
    => ["xxxxxxxxxxxxxxxxxxxx", "yyyyyyyyyyyyyyyyyyyy"] # <= save these for future requests

    # or authorize from previously fetched access keys
    client.authorize_from_access("xxxxxxxxxxxxxxxxxxxx", "yyyyyyyyyyyyyyyyyyyy")

    # you're now free to move about the cabin, call any API method

### Profile examples

    # get the profile for the authenticated user
    client.profile

    # get a profile for someone found in network via ID
    client.profile(:id => '17474922_3b6fca')
