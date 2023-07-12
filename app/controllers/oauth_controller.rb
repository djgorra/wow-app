require 'oauth2'

class OauthController < ApplicationController
    def login
        client = OAuth2::Client.new('6e5be73d7bb84defbfe49d9fb5eb4581', 'R2ulNak8YNKGV4UNoQ74yonVEq4zPMT1',
                            site: 'https://oauth.battle.net/',
                            authorize_url: '/authorize',
                            token_url: '/token')
        redirect_to client.auth_code.authorize_url(redirect_uri: ENV["OAUTH_REDIRECT"], scope: 'wow.profile', state: '123')
    end

    def callback
        code = params[:code]
        client = OAuth2::Client.new('6e5be73d7bb84defbfe49d9fb5eb4581', 'R2ulNak8YNKGV4UNoQ74yonVEq4zPMT1',
                            site: 'https://oauth.battle.net',
                            authorize_url: '/authorize',
                            token_url: '/token')
        @access = client.auth_code.get_token(code, redirect_uri: ENV["OAUTH_REDIRECT"], scope: 'wow.profile', grant_type: 'authorization_code')
        @response = @access.get('/userinfo', params: {'region' => 'us', 'namespace' => 'profile-us', 'locale' => 'en_US'})
    end
end