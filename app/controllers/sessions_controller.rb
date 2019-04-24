class SessionsController < ApplicationController

  def google_login
    # Get access tokens from the google server
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    
    log_in(user)

    token = user.tokens.find_or_initialize_by(provider: 'google')

    # Access_token is used to authenticate request made from the rails application to the google server
    token.access_token = access_token.credentials.token
    token.expires_at = access_token.credentials.expires_at

    # Refresh_token to request new access_token
    # Note: Refresh_token is only sent once during the first request
    refresh_token = access_token.credentials.refresh_token
    token.refresh_token = refresh_token if refresh_token.present?
    
    # save token
    token.save

    # back to root
    redirect_to root_path
  end

  def logout
    log_out

    # back to root
    redirect_to root_path
  end
end