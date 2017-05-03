source 'http://rubygems.org'

gem 'rails', '~> 5.0.2'
gem 'pg'

gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'haml-rails'
gem 'simple_form'
gem 'carrierwave'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'
gem 'file_validators'
gem 'jquery-validation-rails'
gem 'email_validator'
gem 'validates_cpf_cnpj'
gem 'onesignal'
gem 'has_scope'
gem 'simple_captcha', github: 'igormarjes/simple-captcha'

#gem 'core', path: '../extranet/components/core'
gem 'core', github: 'codhab/core'



group :development, :test do
  gem 'byebug', platform: :mri
  gem 'mina', require: false
  gem 'mina-unicorn', require: false
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'unicorn'
  gem 'newrelic_rpm'
end

path 'engines' do
  gem 'attendance'
  gem 'candidate'
  gem 'entity'
  gem 'portal'
end
