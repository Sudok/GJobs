Rails.application.routes.draw do
  resources :jobs

  resources :submissions

  namespace :recruiter do
    mount_devise_token_auth_for 'Recruiter', at: 'auth', as: 'login'
  end
end
