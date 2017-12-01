require 'etude_for_ops'

namespace :ops do
  desc 'Create ops.yml file'
  task :create_ops_yml_onpremis do
    root_dir = Pathname.new('ops')
    FileUtils.mkdir_p(root_dir, mode:0755)
    env = EtudeForOps::Environment.new(root_dir)
    env.template_root_path = EtudeForOps::Onpremis::TEMPLATE_ROOT_PAHT
    env.create_ops_yml
  end

  desc 'Create ops.yml file for aws cloud'
  task :create_ops_yml_aws_cloud do
    root_dir = Pathname.new('ops')
    FileUtils.mkdir_p(root_dir, mode:0755)
    env = EtudeForOps::Environment.new(root_dir)
    aws = EtudeForOps::AWS.new
    env.template_root_path = aws.template_root_path
    env.create_ops_yml
  end

  desc 'Setup ruby development environment'
  task :create_onpremis_ruby_development_env do
    root_dir = Pathname.new('ops')
    ops = EtudeForOps::Ops.new
    ops.create_onpremis_ruby_development_env(root_dir)
  end

  desc 'Setup ruby staging environment'
  task :create_onpremis_ruby_staging_env do
    root_dir = Pathname.new('ops')
    ops = EtudeForOps::Ops.new
    ops.create_onpremis_ruby_staging_env(root_dir)
  end

  desc 'Setup ruby production environment'
  task :create_onpremis_ruby_production_env do
    root_dir = Pathname.new('ops')
    ops = EtudeForOps::Ops.new
    ops.create_onpremis_ruby_production_env(root_dir)
  end

  desc 'Setup ruby share environment'
  task :create_onpremis_ruby_share_env do
    root_dir = Pathname.new('ops')
    ops = EtudeForOps::Ops.new
    ops.create_onpremis_ruby_share_env(root_dir)
  end

  desc 'Setup ruby aws development environment'
  task :create_aws_ruby_development_env do
    root_dir = Pathname.new('ops')
    ops = EtudeForOps::Ops.new
    ops.create_aws_ruby_development_env(root_dir)
  end

  desc 'Setup ruby aws staging environment'
  task :create_aws_ruby_staging_env do
    root_dir = Pathname.new('ops')
    ops = EtudeForOps::Ops.new
    ops.create_aws_ruby_staging_env(root_dir)
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
