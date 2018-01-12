namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/config -p"
      execute "mkdir #{shared_path}/sockets -p"
      execute "mkdir #{shared_path}/pids -p"
      execute "mkdir #{shared_path}/log -p"
    end
  end

  task :start_service do
    on roles(:app) do
      unless test "[ -f #{shared_path.join('tmp', 'pids', 'puma.pid')} ]"
        execute :sudo, :service, :puma, :start
      end
    end
  end

  task :stop_service do
    on roles(:app) do
      execute :sudo, :service, :puma, :stop
    end
  end

  before :check, :make_dirs
  before :start_service, :make_dirs
  before :start, :make_dirs
  before :start, :stop_service
  before :stop,  :stop_service
  before :restart, :stop_service
end
