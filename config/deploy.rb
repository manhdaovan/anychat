# config valid only for current version of Capistrano
lock '3.8.0'

set :application, 'anychat'
set :repo_url, 'git@github.com:manhdaovan/anychat.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 15

namespace :utils do
  desc 'Clear cache'
  task :clear_cache do
    on roles(:web) do
      execute :rake, 'cache:clear'
    end
  end

  desc 'Sync env'
  task :sync_env do
    on roles(:web) do
      unless File.exist?('.env')
        puts "[Error] There is no .env file.\n Exitting. \n "
        exit
      end
      system "scp .env #{fetch(:deployer)}@#{host}:#{shared_path}/"
    end
  end

  desc 'Setup shared path'
  task :setup_shared_path do
    on roles(:web) do
      within shared_path do
        execute :mkdir, '-p tmp/pids tmp/cache tmp/sockets vendor/bundle'
        execute :mkdir, '-p log'
        execute :mkdir, '-p public/system'
      end
    end
  end
end

namespace :nginx do
  desc 'Set maintenance mode'
  task :set_503 do
    on roles(:app) do
      within release_path do
        puts "===== Enable 503 mode to nginx ====="
        execute :touch, 'tmp/maintenance.txt'
      end
    end
  end

  desc 'Unset maintenance mode'
  task :unset_503 do
    on roles(:app) do
      within release_path do
        puts "===== Remove 503 mode to nginx ====="
        execute :rm, 'tmp/maintenance.txt'
      end
    end
  end

  desc 'Restart nginx'
  task :restart do
    on roles(:app) do
      execute :sudo, 'nginx -s reload'
    end
  end
end

namespace :deploy do
  desc 'Init project in first and only first deploy'
  task :init do
    on roles(:app) do
      set :linked_files, ['.env']
      set :linked_dirs, []
      invoke 'deploy'
      invoke 'puma:config'
      invoke 'puma:nginx_config'
    end
  end
end

# before 'deploy:starting', 'nginx:set_503'
# before 'deploy:starting', 'puma:stop'
# before 'deploy:starting', 'utils:clear_cache'
# after 'deploy:finished', 'puma:start'
# after 'deploy:finished', 'nginx:unset_503'