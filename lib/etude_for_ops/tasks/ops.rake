# frozen_string_literal: true

require 'etude_for_ops'
require 'aws-sdk'
require 'dotenv'

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

  desc 'Setup ruby aws production environment'
  task :create_aws_ruby_production_env do
    root_dir = Pathname.new('ops')
    ops = EtudeForOps::Ops.new
    ops.create_aws_ruby_production_env(root_dir)
  end

  desc 'Create .env file for onpremis'
  task :create_env_onpremis do
    root_dir = Pathname.new('ops')
    env = EtudeForOps::Development.new(root_dir)
    env.template_root_path = EtudeForOps::Onpremis::TEMPLATE_ROOT_PAHT
    env.create_env_file('.env')
    env.create_env_file('.env.test')
    env.create_env_file('.env.development')
    env.create_env_file('.env.staging')
    env.create_env_file('.env.production')
  end

  desc 'Create .env file for aws'
  task :create_env_aws do
    root_dir = Pathname.new('ops')
    env = EtudeForOps::Development.new(root_dir)
    env.template_root_path = "#{EtudeForOps::Cloud::TEMPLATE_ROOT_PAHT}/aws"
    env.create_env_file('.env')
    env.create_env_file('.env.test')
    env.create_env_file('.env.development')
    env.create_env_file('.env.staging')
    env.create_env_file('.env.production')
  end

  desc 'Upload the osp.yml files to S3'
  task :upload_to_s3 do
    puts 'Starting ops.yml upload to S3...'
    configure_s3

    file = 'ops.yml'
    file_open   = File.open("ops/#{file}")
    file_key    = file

    @s3.put_object(
      bucket: @bucket,
      body: file_open,
      key: file_key
    )

    puts "Saved #{file} to S3"
  end

  desc 'Download the osp.yml files from S3'
  task :download_from_s3 do
    puts 'Starting ops.yml upload to S3...'
    configure_s3

    file = 'ops.yml'
    target_path = "ops/#{file}"
    file_key = file

    @s3.get_object(
      response_target: target_path,
      bucket: @bucket,
      key: file_key
    )

    puts "Download #{file} form S3"
  end

  desc 'Upload the .env files to S3'
  task :upload_env_to_s3 do
    puts 'Starting .env upload to S3...'
    configure_s3

    files = %w[.env .env.development .env.production .env.staging .env.test]
    files.each do |file|
      file_open   = File.open("#{file}")
      file_key    = file

      @s3.put_object(
        bucket: @bucket,
        body: file_open,
        key: file_key
      )

      puts "Saved #{file} to S3"
    end
  end

  desc 'Download the .env files from S3'
  task :download_env_from_s3 do
    puts 'Starting .env upload to S3...'
    configure_s3

    files = %w[.env .env.development .env.production .env.staging .env.test]
    files.each do |file|
      target_path = "#{file}"
      file_key = file

      @s3.get_object(
        response_target: target_path,
        bucket: @bucket,
        key: file_key
      )

      puts "Download #{file} form S3"
    end
  end
end

def configure_s3
  Dotenv.load
  Aws.config.update(
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_DEFAULT_REGION']
  )
  @s3 = Aws::S3::Client.new
  @bucket = ENV['S3_BUCKET']
end
