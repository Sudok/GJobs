source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.0.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'jbuilder', '~> 2.11', '>= 2.11.5'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'rack-cors', '~> 2.0'
gem 'devise', '~> 4.9'
gem 'devise_token_auth', '~> 1.2.0'
gem 'pg_search', '~> 2.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'database_cleaner'
  gem 'faker'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'rubocop'
  gem 'rubocop-github', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
  gem 'dotenv', '~> 2.7'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
'~> 5.0.0'
