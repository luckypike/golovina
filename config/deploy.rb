# config valid only for current version of Capistrano
lock "~> 3.9"

set :application, 'mint'
set :repo_url, 'git@github.com:luckypike/mint.git'

set :deploy_to, '/home/deploy/apps/mint-store.ru'

set :ssh_options, { forward_agent: true }

append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads", "public/.well-known"

set :keep_releases, 5


after :finishing, 'sitemap:create'