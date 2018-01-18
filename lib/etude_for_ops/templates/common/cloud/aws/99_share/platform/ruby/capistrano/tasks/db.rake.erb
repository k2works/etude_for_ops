namespace :db do
  desc 'Create MySQL Database'
  task :mysql_db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        execute "mysql -h#{fetch(:db_host_ip)} -uapp -p#{fetch(:db_root_pass)} -e 'CREATE DATABASE IF NOT EXISTS #{fetch(:db_name)};'"
      end
    end
  end

  desc 'Create Postgresql Database'
  task :pg_db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        execute "PGPASSWORD=#{fetch(:db_root_pass)} psql -h #{fetch(:db_host_ip)} -U app postgres -c 'CREATE DATABASE #{fetch(:db_name)};'"
      end
    end
  end

  desc 'Upload database.yml'
  task :config_upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
    end
  end

  desc 'Upload latest dumpfile or specific file'
  task :dump_upload, :file do |task, args|
    on roles(:app) do |host|
      environment = fetch(:rails_env)
      dump_dir = "db/dumps/#{environment}"
      if test "[ ! -d #{current_path}/#{dump_dir} ]"
        execute "mkdir -p #{current_path}/#{dump_dir}"
      end

      if args[:file].nil?
        days = []
        Dir.glob("#{dump_dir}/*").each do |file|
          days << Date.parse(File.basename(file, '.dump'))
        end
        dump_file = "#{days.max}.dump"
      else
        dump_file = "#{args[:file]}.dump"
      end

      upload!("#{dump_dir}/#{dump_file}", "#{current_path}/#{dump_dir}")
    end
  end

  desc 'Download latest dumpfile'
  task :dump_download do
    on roles(:app) do |host|
      environment = fetch(:rails_env)
      dump_dir = "db/dumps/#{environment}"
      dump_file = "#{Date.today.strftime("%Y-%m-%d")}.dump"
      download!("#{current_path}/#{dump_dir}/#{dump_file}" ,"#{dump_dir}/#{dump_file}")
    end
  end

  desc 'Create Database'
  task :create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Drop Database'
  task :drop do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:drop'
        end
      end
    end
  end

  desc 'Migrate Database'
  task :create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:migrate'
        end
      end
    end
  end

  desc 'Rollback Database'
  task :create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:rollback'
        end
      end
    end
  end

  desc 'Create Seed'
  task :seed do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  desc 'Dumps the database by date'
  task :dump_all do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:dump_all'
        end
      end
    end
  end

  desc 'Import latest dumps'
  task :import_all, :name do |task, args|
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, "db:import_all[#{args[:name]}]"
        end
      end
    end
  end

  desc 'Delete dumpfile except latest dumps'
  task :dump_clean do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:dump_clean'
        end
      end
    end
  end  
end
