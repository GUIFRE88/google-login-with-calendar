class SessionsController < ApplicationController

  def google_login
    # Get access tokens from the google server
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)
    
    log_in(user)

    token = user.tokens.find_or_initialize_by(provider: 'google')

    # Access token is used to authenticate requests
    token.auth = auth.credentials.token
    token.expires_at = auth.credentials.expires_at

    # Refresh_token to request new access token
    # Note: Refresh_token is only sent once during the first request
    # After the second login etc this won't be returned
    refresh_token = auth.credentials.refresh_token
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