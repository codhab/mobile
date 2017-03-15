source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

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

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

path 'engines' do 
  gem 'attendance'
  gem 'candidate'
end