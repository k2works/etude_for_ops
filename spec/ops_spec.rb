require 'rspec'

describe 'EtudeForOps::Ops' do
  context 'onpremis' do
    describe '#create_onpremis_development_env' do
      it 'create development environment'
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