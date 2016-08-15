class SessionsController < ApplicationController

	skip_before_action :authenticate_user, only: :create

def create
  resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
    req.params['client_id'] = 'JWOF4PVNBP0SFC3Q2TYP4NYJ4NAFWLS5C0N22BFGWEXCIS3C'
    req.params['client_secret'] = 'PZY4CPO00R3RVQTIQEXMA3IPP0XZMKJJF2TTY1X3ETXTYC1N'
    req.params['grant_type'] = 'authorization_code'
    req.params['redirect_uri'] = "http://localhost:3000/auth"
    req.params['code'] = params[:code]
  end
 
  body = JSON.parse(resp.body)
  session[:token] = body["access_token"]
  redirect_to root_path
end

end
