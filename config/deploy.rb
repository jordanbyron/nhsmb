require "whenever/capistrano"

set :application, "nhsmb"
set :repository,  "git://github.com/jordanbyron/nhsmb.git"

set :scm, :git
set :deploy_to, "~/#{application}"

set :user, "jordanbyron"
set :use_sudo, false

set :deploy_via, :remote_cache

server "jordanbyron.com", :app, :web, :db, :primary => true

after 'deploy:update_code' do
  run "cd #{release_path}; mm-build"
  run "ln -nfs #{shared_path}/downloads/audio #{release_path}/build/downloads/"
  run "ln -nfs #{shared_path}/downloads/documents #{release_path}/build/downloads/"
  run_locally "rsync -ruv public/downloads/documents/* jordanbyron@jordanbyron.com:#{shared_path}/downloads/documents/"
  run_locally "rsync -ruv public/downloads/audio/* jordanbyron@jordanbyron.com:#{shared_path}/downloads/audio/"
end

after "deploy", "deploy:cleanup"