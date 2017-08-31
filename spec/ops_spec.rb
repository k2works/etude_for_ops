require 'spec_helper'
require 'pathname'

describe 'EtudeForOps::Ops' do
  root_dir = Pathname.new('ops')
  dev_dir = Pathname.new('ops/01_development')
  dev_conf_dir = Pathname.new('ops/01_development/config')
  dev_conf_env_dir = Pathname.new('ops/01_development/config/env')
  dev_conf_secure_dir = Pathname.new('ops/01_development/config/secure')
  dev_src_dir = Pathname.new('ops/01_development/src')
  dev_src_build_dir = Pathname.new('ops/01_development/src/build')
  dev_src_ship_dir = Pathname.new('ops/01_development/src/ship')
  dev_src_run_dir = Pathname.new('ops/01_development/src/run')

  context 'onpremis' do
    describe '#create_onpremis_development_env' do
      it 'create development environment' do
        ops = EtudeForOps::Ops.new
        ops.create_onpremis_development_env
        expect(root_dir).to exist
        expect(dev_dir).to exist
        expect(dev_conf_dir).to exist
        expect(dev_conf_env_dir).to exist
        expect(dev_conf_secure_dir).to exist
        expect(dev_src_dir).to exist
        expect(dev_src_build_dir).to exist
        expect(dev_src_ship_dir).to exist
        expect(dev_src_run_dir).to exist
      end
    end

    describe '#create_onpremis_staging_env' do
      it 'create staging environment'
    end

    describe '#create_onpremis_production_env' do
      it 'create production environment'
    end
  end

  context 'cloud' do
    describe '#create_aws_development_env' do
      it 'create development environment'
    end

    describe '#create_aws_staging_env' do
      it 'create staging environment'
    end

    describe '#create_aws_production_env' do
      it 'create production environment'
    end
  end
end