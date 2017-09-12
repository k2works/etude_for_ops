# config valid only for current version of Capistrano
lock '3.9.1'

set :application, "app"
set :deploy_to, "/var/#{fetch(:application)}"
set :repo_url, 'https://github.com/k2works/etude_for_rails.git'
set :deploy_via, :remote_cache
set :keep_releases, 5
set :log_level, :debug
set :use_sudo, false
set :pty, true
set :rbenv_ruby, '2.4.1'
set :db_root_pass, 'password'
set :db_host_ip, '127.0.0.1'

# 必要に応じて、gitignoreしているファイルにLinkを貼る
#set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')

# デプロイ用環境変数の設定
set :default_env, {
    AWS_ACCESS_KEY_ID: ENV["AWS_ACCESS_KEY_ID"],
    AWS_SECRET_ACCESS_KEY: ENV["AWS_SECRET_ACCESS_KEY"],
    S3_REGION: ENV["S3_REGION "],
    S3_ACCESS_KEY: ENV["S3_ACCESS_KEY"],
    S3_SECRET_KEY: ENV["S3_SECRET_KEY"],
    S3_BUCKET: ENV["S3_BUCKET"],
}

# shared/puma.rb
set :puma_threds,  [4, 16]
set :puma_workers, 0
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_error_log, "#{release_path}/log/puma.error.log"
set :puma_access_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub), port: 22 }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:production) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'db:mysql_db_create'
      invoke 'db:pg_db_create'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end
