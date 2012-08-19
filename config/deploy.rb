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
  remote_path = shared_path[2..-1]

  run "cd #{release_path}; mm-build"

  %w{audio documents sheet_music drill}.each do |folder|
    run "ln -nfs #{shared_path}/downloads/#{folder} #{release_path}/build/downloads/"
    run_locally "rsync -ruv public/downloads/#{folder}/* jordanbyron@jordanbyron.com:#{remote_path}/downloads/#{folder}/"
  end
end

after "deploy", "deploy:cleanup"