Rails.application.routes.draw do
  resources :jobs

  namespace :recruiter do
    mount_devise_token_auth_for 'Recruiter', at: 'auth', as: 'login'
  end

  namespace :publica do
    resources :submissions
  end
end
