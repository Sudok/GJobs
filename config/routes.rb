Rails.application.routes.draw do
  namespace :recruiter do
    mount_devise_token_auth_for 'Recruiter', at: 'auth'
  end
end
