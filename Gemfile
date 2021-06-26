source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '~> 6.1.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'

gem 'jbuilder', '~> 2.7'
gem 'devise', '~> 4.8'
gem 'bootstrap', '5.0.0'
gem 'devise-bootstrapped', github: 'king601/devise-bootstrapped', branch: 'bootstrap4'
gem 'devise-pwned_password'
gem 'gravatar_image_tag', github: 'secretpray/gravatar_image_tag', branch: 'master'
gem 'slim', '~> 4.1'
gem 'font-awesome-sass', '~> 5.15'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'
gem 'mini_magick'
gem "pundit"
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', branch: 'master'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'friendly_id', '~> 5.4.0'
gem 'acts_as_votable'
gem 'ancestry'
gem 'ransack'
gem 'pg_search'
gem 'rails-i18n'
gem 'aws-sdk-s3', require: false
gem 'rails-social-share-button'
# Add wizard
gem 'wicked'
# Add Markdown
gem "redcarpet"
# PDF
gem 'wicked_pdf'
gem 'grover'
#pagination
gem 'pagy'
# OmniAuth
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'activerecord-session_store'
gem "omniauth-rails_csrf_protection"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry', '~> 0.13.1'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'factory_bot_rails'
  gem "brakeman"
  gem "standard"
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem "letter_opener"
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'rails-controller-testing'
  gem 'launchy', '~> 2.4', '>= 2.4.3'
  # It allows you to run your Capybara tests in the Chrome browser via CDP (no selenium or chromedriver needed)
  gem 'apparition'
end
