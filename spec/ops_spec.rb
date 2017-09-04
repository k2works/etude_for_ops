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

  context 'onpremis' do
    before(:all) do
      FileUtils.rm_rf(root_dir)
    end

    context 'ruby platform' do
      describe '#create_onpremis_ruby_development_env' do
        it 'create development environment' do
          env,plt,stg = ops.create_onpremis_ruby_development_env(root_dir)

          expect(env.class).to be EtudeForOps::Development
          expect(plt.class).to be EtudeForOps::Ruby
          expect(stg.class).to be EtudeForOps::Onpremis
          set_expect_dir.call('01_development')
          check_dir_exist(dir, root_dir)
        end

        it 'create development files' do
          env_dir_file = Pathname.new(dir[:env_dir] + 'README.md')
          vagrant_file = Pathname.new(dir[:env_dir] + 'Vagrantfile')
          set_dev_env_file = Pathname.new(dir[:env_conf_env_dir] + 'set-dev-env.sh')
          expect(env_dir_file).to exist
          expect(vagrant_file).to exist
          expect(set_dev_env_file).to exist

          chef_dir = Pathname.new(dir[:env_src_build_dir] + 'chef')
          expect(chef_dir).to exist
          chef_file = Pathname.new(chef_dir + 'chef.json')
          expect(chef_file).to exist
        end
      end

      describe '#create_onpremis_staging_env' do
        it 'create staging environment' do
          env = ops.create_onpremis_staging_env(root_dir)

          expect(env.class).to be EtudeForOps::Staging
          set_expect_dir.call('02_staging')
          check_dir_exist(dir, root_dir)
        end
      end

      describe '#create_onpremis_production_env' do
        it 'create production environment' do
          env = ops.create_onpremis_production_env(root_dir)

          expect(env.class).to be EtudeForOps::Production
          set_expect_dir.call('03_production')
          check_dir_exist(dir, root_dir)
        end
      end

      describe '#create_onpremis_share_env' do
        it 'create production environment' do
          env = ops.create_onpremis_share_env(root_dir)

          expect(env.class).to be EtudeForOps::Share
          set_expect_dir.call('99_share')
          check_dir_exist(dir, root_dir)
        end
      end
    end
  end

  context 'cloud' do
    before(:all) do
      #FileUtils.rm_rf(root_dir)
    end

    describe '#create_aws_development_env' do
      it 'create development environment' do
        env = ops.create_aws_development_env(root_dir)

        expect(env.class).to be EtudeForOps::Development
        set_expect_dir.call('01_development')
        check_dir_exist(dir, root_dir)
      end
    end

    describe '#create_aws_staging_env' do
      it 'create staging environment' do
        env = ops.create_aws_staging_env(root_dir)

        expect(env.class).to be EtudeForOps::Staging
        set_expect_dir.call('02_staging')
        check_dir_exist(dir, root_dir)
      end
    end

    describe '#create_aws_production_env' do
      it 'create production environment' do
        env = ops.create_aws_production_env(root_dir)

        expect(env.class).to be EtudeForOps::Production
        set_expect_dir.call('03_production')
        check_dir_exist(dir, root_dir)
      end
    end

    describe '#create_aws_share_env' do
      it 'create production environment' do
        env = ops.create_aws_share_env(root_dir)

        expect(env.class).to be EtudeForOps::Share
        set_expect_dir.call('99_share')
        check_dir_exist(dir, root_dir)
      end
    end
  end
end