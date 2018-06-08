
gem 'lightbox2-rails'
source 'http://rubygems.org'

gem 'rails', '~> 5.0.2'
gem 'pg', '~> 0.20'

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
gem 'bcrypt'

gem 'lightbox2-rails'

gem 'core', github: 'codhab/core', branch: :master

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'mina', require: false
  gem 'mina-unicorn', require: false
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'derailed_benchmarks'
  gem 'stackprof'
  gem 'guard-livereload'
  gem 'guard-rails', require: false
end

group :production do
  gem 'unicorn'
  gem 'newrelic_rpm'
  gem 'unicorn-worker-killer'
end

path 'engines' do
  gem 'attendance'
  gem 'candidate'
  gem 'entity'
  gem 'person'
  gem 'portal'
  gem 'protocol'
  gem 'social'
  gem 'healty'
  gem 'regularization'
  gem 'technical_assistance'
end
