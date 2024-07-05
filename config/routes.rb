require "sidekiq/web"

Rails.application.routes.draw do
  # Configure Sidekiq-specific session middleware
  Sidekiq::Web.use ActionDispatch::Cookies
  Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

  mount Sidekiq::Web => "/sidekiq"

  resources :jobs

  resources :submissions

  namespace :recruiter do
    mount_devise_token_auth_for 'Recruiter', at: 'auth', as: 'login'
  end
end
