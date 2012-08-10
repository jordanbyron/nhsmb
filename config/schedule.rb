set :output, "/home/jordanbyron/nhsmb/logs/cron_log.log"

every 1.day do
  command 'cd /home/jordanbyron/nhsmb/current; mm-build'
end