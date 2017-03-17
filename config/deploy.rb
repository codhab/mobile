require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/puma'

set :domain, '10.233.38.18'
set :sudo, 'true'
set :rvm_use_path, '/usr/local/rvm/scripts/rvm'

if ENV["STAGE"] == "dev"
  set :deploy_to, '/var/www/application/development/mobile'
else
  set :deploy_to, '/var/www/application/production/mobile'
end

set  :repository, 'https://github.com/codhab/mobile.git'
set  :branch, ENV["BRANCH"] ||= 'master'

set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp/pids', 'tmp/sockets', 'public')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml', 'config/puma.rb')

set :user, 'root'


task :setup do
  command %[touch "#{fetch(:shared_path)}/config/database.yml"]
  command %[touch "#{fetch(:shared_path)}/config/secrets.yml"]
  command %[touch "#{fetch(:shared_path)}/config/puma.rb"]
  comment "Be sure to edit '#{fetch(:shared_path)}/config/database.yml', 'secrets.yml' and puma.rb."
end

task :environment do
  invoke :'rvm:use', '2.4.0'
end

task :deploy do
  deploy do
    invoke  :'git:clone'
    invoke  :'deploy:link_shared_paths'
    invoke  :'bundle:install'
    invoke  :'rails:assets_precompile'
    invoke  :'deploy:cleanup'
    on :launch do
      invoke :'puma:phased_restart'
    end
  end
end

