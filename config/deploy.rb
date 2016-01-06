# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'xurisso'
set :repo_url, 'git@github.com:diegorubin/xurisso-community.git'

set :linked_files, %w{
  config/database.yml config/initializers/devise.rb 
  config/initializers/setup_mail.rb config/newrelic.yml
  config/environments/production.rb config/unicorn.rb
  config/secrets.yml
}

set :linked_dirs, %w{pids log public/uploads uploads}

set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"
set :unicorn_config_path, "#{shared_path}/config/unicorn.rb"

namespace :delayed_job do

  desc 'stop delayed job'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      if Dir.exists?(release_path)
        execute "cd '#{release_path}';RAILS_ENV=production bin/delayed_job stop"
      end
    end
  end

  desc 'start delayed job'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd '#{release_path}';RAILS_ENV=production bin/delayed_job start"
    end
  end

end

namespace :deploy do

  desc 'Restart application'
  namespace :deploy do
    task :restart do
      invoke 'unicorn:restart'
    end
  end

  before :deploy, 'delayed_job:stop'

  after :deploy, 'delayed_job:start'
  after 'deploy:publishing', 'deploy:restart'

end

