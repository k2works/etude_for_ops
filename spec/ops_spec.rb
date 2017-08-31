require 'spec_helper'
require 'pathname'

def check_dir_exist(dir, root_dir)
  expect(root_dir).to exist
  expect(dir[:env_dir]).to exist
  expect(dir[:env_conf_dir]).to exist
  expect(dir[:env_conf_env_dir]).to exist
  expect(dir[:env_conf_secure_dir]).to exist
  expect(dir[:env_src_dir]).to exist
  expect(dir[:env_src_build_dir]).to exist
  expect(dir[:env_src_ship_dir]).to exist
  expect(dir[:env_src_run_dir]).to exist
end

describe 'EtudeForOps::Ops' do
  let(:ops) { EtudeForOps::Ops.new }

  root_dir = Pathname.new('ops')
  dir = {}
  set_expect_dir = ->(env_name) do
    dir[:env_name] = env_name
    dir[:env_dir] = Pathname.new("#{root_dir}/#{dir[:env_name]}")
    dir[:env_conf_dir] = Pathname.new("#{dir[:env_dir]}/config")
    dir[:env_conf_env_dir] = Pathname.new("#{dir[:env_dir]}/config/env")
    dir[:env_conf_secure_dir] = Pathname.new("#{dir[:env_dir]}/config/secure")
    dir[:env_src_dir] = Pathname.new("#{dir[:env_dir]}/src")
    dir[:env_src_build_dir] = Pathname.new("#{dir[:env_dir]}/src/build")
    dir[:env_src_ship_dir] = Pathname.new("#{dir[:env_dir]}/src/ship")
    dir[:env_src_run_dir] = Pathname.new("#{dir[:env_dir]}/src/run")
  end

  context 'development' do
    before(:each) do
      FileUtils.rm_rf(root_dir)
    end

    context 'onpremis' do
      describe '#create_onpremis_development_env' do
        it 'create development environment' do
          env = ops.create_onpremis_development_env(root_dir)

          expect(env.class).to be EtudeForOps::Development
          set_expect_dir.call('01_development')
          check_dir_exist(dir, root_dir)
        end
      end
    end

    context 'cloud' do
      describe '#create_aws_development_env' do
        it 'create development environment' do
          env = ops.create_aws_development_env(root_dir)

          expect(env.class).to be EtudeForOps::Development
          set_expect_dir.call('01_development')
          check_dir_exist(dir, root_dir)
        end
      end
    end
  end

  context 'staging' do
    context 'onpremis' do
      describe '#create_onpremis_staging_env' do
        it 'create staging environment' do
          env = ops.create_onpremis_staging_env(root_dir)

          expect(env.class).to be EtudeForOps::Staging
          set_expect_dir.call('02_staging')
          check_dir_exist(dir, root_dir)
        end
      end
    end

    context 'cloud' do
      describe '#create_aws_staging_env' do
        it 'create staging environment' do
          env = ops.create_aws_staging_env(root_dir)

          expect(env.class).to be EtudeForOps::Staging
          set_expect_dir.call('02_staging')
          check_dir_exist(dir, root_dir)
        end
      end
    end
  end

  context 'production' do
    context 'onpremis' do
      describe '#create_onpremis_production_env' do
        it 'create production environment' do
          env = ops.create_onpremis_production_env(root_dir)

          expect(env.class).to be EtudeForOps::Production
          set_expect_dir.call('03_production')
          check_dir_exist(dir, root_dir)
        end
      end
    end

    context 'cloud' do
      describe '#create_aws_production_env' do
        it 'create production environment' do
          env = ops.create_aws_production_env(root_dir)

          expect(env.class).to be EtudeForOps::Production
          set_expect_dir.call('03_production')
          check_dir_exist(dir, root_dir)
        end
      end
    end
  end
end