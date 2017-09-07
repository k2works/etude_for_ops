require 'etude_for_ops'

namespace :ops do
  desc 'Setup ruby development environment'
  task :create_onpremis_ruby_development_env do
    root_dir = Pathname.new('ops')
    ops = EtudeForOps::Ops.new
    ops.create_onpremis_ruby_development_env(root_dir)
  end

  desc 'Create .env file for onpremis development'
  task :create_env_onpremis_dev do
    root_dir = Pathname.new('ops')
    env = EtudeForOps::Development.new(root_dir)
    env.template_root_path = EtudeForOps::Onpremis::TEMPLATE_ROOT_PAHT
    env.create_env_file('.env.development')
    env.create_env_file('.env.test')
  end

  desc 'Create .env file for onpremis staging'
  task :create_env_onpremis_stg do
    root_dir = Pathname.new('ops')
    env = EtudeForOps::Staging.new(root_dir)
    env.template_root_path = EtudeForOps::Onpremis::TEMPLATE_ROOT_PAHT
    env.create_env_file('.env.staging')
  end

  desc 'Create .env file for onpremis production'
  task :create_env_onpremis_prd do
    root_dir = Pathname.new('ops')
    env = EtudeForOps::Production.new(root_dir)
    env.template_root_path = EtudeForOps::Onpremis::TEMPLATE_ROOT_PAHT
    env.create_env_file('.env.production')
  end
end