# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "nhsmb"
set :repo_url, "https://github.com/jordanbyron/nhsmb.git"

set :stage, :production
server "jordanbyron.com", roles: [:app, :web, :db]

if match = `git branch`.match(/\* (?<branch>\S+)\s/m)
  set :branch, match[:branch]
else
  set :branch, "master"
end

set :deploy_to, "~/#{fetch(:application)}"

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, "build/downloads"

before 'deploy:publishing', 'mm-build' do
  on roles(:all) do |host|
    execute "cd #{release_path}; rvm 2.4.3 do bundle exec mm-build"

    %w{audio documents sheet_music drill}.each do |folder|
      remote_folder = "#{shared_path}/build/downloads/#{folder}"
      execute "mkdir -p #{remote_folder}"
      `rsync -ruv public/downloads/#{folder}/* jordanbyron@jordanbyron.com:#{remote_folder}/`
    end
  end
end
