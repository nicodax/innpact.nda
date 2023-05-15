# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :job_template, "/bin/bash -l -c 'eval \"$(rbenv init -)\"; :job'"
set :output, File.expand_path('../log/cron.log', __dir__)
env :PATH, ENV.fetch('PATH', nil)

every 1.month do
  rake 'monthly_table:create'
end

every 1.day do
  rake 'daily_task:update_status_invested_to_matured'
end
