namespace :active_job do
  desc 'Create Directories for Pids'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/pids -p"
      execute "mkdir #{shared_path}/log -p"
    end
  end

  desc 'Start ActiveJob Service'
  task :start do
    on roles(:app) do
      execute :sudo, :systemctl, :start, :active_job
    end
  end

  desc 'Stop ActiveJob Service'
  task :stop do
    on roles(:app) do
      execute :sudo, :systemctl, :stop, :active_job
    end
  end

  desc 'Restart ActiveJob Service'
  task :restart do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, :active_job
    end
  end

  before :start, :make_dirs
end
