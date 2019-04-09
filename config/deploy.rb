# config valid only for current version of Capistrano
lock "~> 3"

set :application, 'golovina'
set :repo_url, 'git@github.com:luckypike/golovina.git'

set :deploy_to, '/home/deploy/apps/golovina.store'

set :ssh_options, { forward_agent: true }

append :linked_files, 'config/database.yml'
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads"

set :keep_releases, 5

# after 'deploy:finishing', 'sitemap:create'
