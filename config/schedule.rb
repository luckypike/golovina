# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


job_type :rake, 'export PATH="$HOME/.rbenv/bin:$PATH"; eval "$(rbenv init -)"; cd :path && :environment_variable=:environment bundle exec rake :task --silent :output'

every :day, at: '00:20' do
  command "$HOME/.rbenv/shims/backup perform -t golovina"
end

every 5.minutes do
  rake 'jobs:workoff'
  rake 'variants:images'
end
