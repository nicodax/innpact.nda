# config valid for current version and patch releases of Capistrano
# lock "~> 3.11.0"

set :application, 'innpact.com'
set :repo_url, 'git@github.com:belighted/innpact.git'
set :log_level, "info"
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp


# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/master.key', 'config/version.json'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'storage', 'public/uploads', 'documents'

# Default value for keep_releases is 5
set :keep_releases, 5

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, File.read('.ruby-version').strip

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, File.read('.nvmrc').strip
set :nvm_map_bins, %w{node npm yarn}

set :yarn_flags, '--production --silent --no-progress'

set :default_env, {
  PATH: "$HOME/.nvm/versions/node/#{fetch(:nvm_node)}/bin/:$PATH",
  NODE_ENVIRONMENT: 'production'
}

# Uncomment if you need whenever implementation
set :whenever_environment, fetch(:stage)
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

