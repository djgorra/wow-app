class OauthController < ApplicationController
    def login
        client = OAuth2::Client.new('6e5be73d7bb84defbfe49d9fb5eb4581', 'R2ulNak8YNKGV4UNoQ74yonVEq4zPMT1',
                            site: 'https://oauth.battle.net/',
                            authorize_url: '/authorize',
                            token_url: '/token')
        client.auth_code.authorize_url(redirect_uri: 'https://wow-app-rails-5c78013cc11c.herokuapp.com/oauth2/callback')
        redirect_to client.auth_code.authorize_url(redirect_uri: 'https://wow-app-rails-5c78013cc11c.herokuapp.com/oauth2/callback')
    end

    def callback
    end
end