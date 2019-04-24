Rails.application.routes.draw do

  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#google_login'
  get 'auth/failure', to: redirect('/')
  # /auth/google_oauth2 is our google login starter point
  get 'login', to: redirect('/auth/google_oauth2')
  get 'logout', to: 'sessions#logout'

  # Events page
  get 'events/index'

  # root
  root 'home#index'
end
