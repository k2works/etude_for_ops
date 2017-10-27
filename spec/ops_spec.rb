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
  let(:ops) {EtudeForOps::Ops.new}

  root_dir = Pathname.new('spec/ops')
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
        before(:each) do
          set_expect_dir.call('01_development')
        end

        it 'create development environment' do
          env, plt, stg = ops.create_onpremis_ruby_development_env(root_dir)

          expect(env.class).to be EtudeForOps::Development
          expect(plt[0].class).to be EtudeForOps::Ruby
          expect(stg.class).to be EtudeForOps::Onpremis
          check_dir_exist(dir, root_dir)
        end

        it 'create development files' do
          env_dir_file = Pathname.new(dir[:env_dir] + 'README.md')
          vagrant_file = Pathname.new(dir[:env_dir] + 'Vagrantfile')
          set_dev_env_file = Pathname.new(dir[:env_conf_env_dir] + 'set-dev-env.sh')
          expect(env_dir_file).to exist
          expect(vagrant_file).to exist
          expect(set_dev_env_file).to exist
        end

        it 'create config files' do
          config_dir = Pathname.new(dir[:env_conf_dir] + 'env')
          expect(config_dir).to exist

          config_files = %w(
           set-dev-env.sh
           set-share-env.sh
           )
          config_files.each do |file|
            expect(Pathname.new(config_dir + file)).to exist
          end
        end

        it 'create build chef files' do
          chef_dir = Pathname.new(dir[:env_src_build_dir] + 'chef')
          expect(chef_dir).to exist

          chef_files = %w[
           attributes_default.rb
           metadata.rb
           provision.json
           recipes_default.rb
           recipes_setup.rb
           recipes_configure.rb
           recipes_configure_service.rb
           recipes_setup_ruby.rb
           recipes_setup_mysql.rb
           recipes_setup_postgres.rb
           recipes_setup_redis.rb
           recipes_setup_mongodb.rb
           recipes_setup_node.rb
           recipes_setup_nginx.rb
           recipes_setup_service.rb
           recipes_setup_td-agent.rb
           recipes_setup_elasticsearch.rb
           recipes_setup_docker.rb
           recipes_setup_jenkins.rb
           recipes_setup_aws.rb
           recipes_setup_vagrant.rb
          ]

          chef_files.each do |file|
            expect(Pathname.new(chef_dir + file)).to exist
          end

          chef_erb_template_files = %w[
           templates_default_banner.erb
           templates_default_bash_profile.erb
           templates_default_grants.sql.erb
           templates_default_my_extra_settings.erb
           templates_default_nginx.conf.erb
           templates_default_nginx.default.conf.erb
           templates_default_nginx.proxy.conf.erb
           templates_default_nginx.kibana.conf.erb
           templates_default_nginx.jenkins.conf.erb
           templates_default_puma.erb
           templates_default_puma.service.erb
           templates_default_active_job.erb
           templates_default_active_job.service.erb
           templates_default_td-agent-ui.erb
           templates_default_td-agent-ui.service.erb
           templates_default_kibana.yml.erb
           templates_default_jenkins.erb
          ]

          chef_erb_template_files.each do |file|
            expect(Pathname.new(chef_dir + file)).to exist
          end
        end

        it 'create build sh files' do
          sh_dir = Pathname.new(dir[:env_src_build_dir] + 'sh')
          expect(sh_dir).to exist

          sh_files = %w[
          build.sh
          ]

          sh_files.each do |file|
            expect(Pathname.new(sh_dir + file)).to exist
          end
        end

        it 'create ship capistrano files' do
          cap_dir = Pathname.new(dir[:env_src_ship_dir] + 'capistrano')
          cap_puma_dir = Pathname.new(cap_dir + 'puma')
          cap_tasks_dir = Pathname.new(cap_dir + 'tasks')
          cap_td_agent_dir = Pathname.new(cap_dir + 'td-agent')
          expect(cap_dir).to exist
          expect(cap_puma_dir).to exist
          expect(cap_tasks_dir).to exist
          expect(cap_td_agent_dir).to exist

          cap_puma_files = %w[
           Capfile
           deploy.rb
           development.rb
           maintenance.html.erb
          ]
          cap_tasks_files = %w[
           active_job.rake
           db.rake
           puma.rake
           td-agent.rake
          ]
          cap_td_agent_files = %w[
           fluent-logger.yml
           td-agent.conf
          ]

          cap_puma_files.each do |file|
            expect(Pathname.new(cap_puma_dir + file)).to exist
          end
          cap_tasks_files.each do |file|
            expect(Pathname.new(cap_tasks_dir + file)).to exist
          end
          cap_td_agent_files.each do |file|
            expect(Pathname.new(cap_td_agent_dir + file)).to exist
          end
        end

        it 'create ship sh files' do
          sh_dir = Pathname.new(dir[:env_src_ship_dir] + 'sh')
          expect(sh_dir).to exist

          sh_files = %w[
          ship.sh
          ]

          sh_files.each do |file|
            expect(Pathname.new(sh_dir + file)).to exist
          end
        end

        it 'create ship vagrant files' do
          vagrant_dir = Pathname.new(dir[:env_src_ship_dir] + 'vagrant')
          expect(vagrant_dir).to exist

          vagrant_files = %w[
          create_box.sh
          metadata.json
          ]

          vagrant_files.each do |file|
            expect(Pathname.new(vagrant_dir + file)).to exist
          end
        end

        it 'create run config files' do
          config_dir = Pathname.new(dir[:env_src_run_dir] + 'config')
          expect(config_dir).to exist

          config_files = %w[
           schedule.rb
           sidekiq.rb
           sidekiq.yml
          ]

          config_files.each do |file|
            expect(Pathname.new(config_dir + file)).to exist
          end
        end

        it 'create run rake files' do
          rake_dir = Pathname.new(dir[:env_src_run_dir] + 'rake')
          expect(rake_dir).to exist

          rake_files = %w[
           db.rake
          ]

          rake_files.each do |file|
            expect(Pathname.new(rake_dir + file)).to exist
          end
        end

        it 'create run sh files' do
          sh_dir = Pathname.new(dir[:env_src_run_dir] + 'sh')
          expect(sh_dir).to exist

          sh_files = %w[
           run.sh
          ]

          sh_files.each do |file|
            expect(Pathname.new(sh_dir + file)).to exist
          end
        end
      end

      describe '#create_onpremis_ruby_staging_env' do
        it 'create staging environment' do
          env, plt, stg = ops.create_onpremis_ruby_staging_env(root_dir)

          expect(env.class).to be EtudeForOps::Staging
          expect(plt[0].class).to be EtudeForOps::Ruby
          expect(stg.class).to be EtudeForOps::Onpremis

          set_expect_dir.call('02_staging')
          check_dir_exist(dir, root_dir)
        end
      end

      describe '#create_onpremis_ruby_production_env' do
        it 'create production environment' do
          env, plt, stg = ops.create_onpremis_ruby_production_env(root_dir)

          expect(env.class).to be EtudeForOps::Production
          expect(plt[0].class).to be EtudeForOps::Ruby
          expect(stg.class).to be EtudeForOps::Onpremis

          set_expect_dir.call('03_production')
          check_dir_exist(dir, root_dir)
        end
      end

      describe '#create_onpremis_ruby_share_env' do
        it 'create production environment' do
          env, plt, stg = ops.create_onpremis_ruby_share_env(root_dir)

          expect(env.class).to be EtudeForOps::Share
          expect(plt[0].class).to be EtudeForOps::Ruby
          expect(stg.class).to be EtudeForOps::Onpremis


          set_expect_dir.call('99_share')
          check_dir_exist(dir, root_dir)
        end
      end
    end
  end

  context 'cloud' do
    before(:all) do
      FileUtils.rm_rf(root_dir)
    end

    context 'amazon web service' do
      context 'ruby platform' do
        describe '#create_aws_ruby_development_env' do
          it 'create development environment' do
            env, plt, stg = ops.create_aws_ruby_development_env(root_dir)

            expect(env.class).to be EtudeForOps::Development
            expect(plt[0].class).to be EtudeForOps::AWS
            expect(plt[1].class).to be EtudeForOps::Ruby
            expect(stg.class).to be EtudeForOps::Cloud

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
          end

          it 'create config files' do
            config_dir = Pathname.new(dir[:env_conf_dir] + 'env')
            expect(config_dir).to exist

            config_files = %w(
           set-dev-env.sh
           set-share-env.sh
           )
            config_files.each do |file|
              expect(Pathname.new(config_dir + file)).to exist
            end
          end

          it 'create build chef files' do
            chef_dir = Pathname.new(dir[:env_src_build_dir] + 'chef')
            expect(chef_dir).to exist

            chef_files = %w[
             attributes_default.rb
             metadata.rb
             provision.json
             ec2_provision.json
             recipes_default.rb
             recipes_ec2.rb
             recipes_setup.rb
             recipes_configure.rb
             recipes_configure_service.rb
             recipes_setup_ruby.rb
             recipes_setup_mysql.rb
             recipes_setup_postgres.rb
             recipes_setup_redis.rb
             recipes_setup_mongodb.rb
             recipes_setup_node.rb
             recipes_setup_nginx.rb
             recipes_setup_service.rb
             recipes_setup_td-agent.rb
             recipes_setup_elasticsearch.rb
             recipes_setup_docker.rb
             recipes_setup_jenkins.rb
             recipes_setup_aws.rb
             recipes_setup_vagrant.rb
             Vagrantfile
             .kitchen.yml
             Gemfile
             reprovision.sh
            ]

            chef_files.each do |file|
              expect(Pathname.new(chef_dir + file)).to exist
            end

            chef_erb_template_files = %w[
             templates_default_banner.erb
             templates_default_bash_profile.erb
             templates_default_bash_profile_aws.erb
             templates_default_grants.sql.erb
             templates_default_my_extra_settings.erb
             templates_default_nginx.conf.erb
             templates_default_nginx.default.conf.erb
             templates_default_nginx.proxy.conf.erb
             templates_default_nginx.kibana.conf.erb
             templates_default_nginx.jenkins.conf.erb
             templates_default_puma.erb
             templates_default_puma.service.erb
             templates_default_active_job.erb
             templates_default_active_job.service.erb
             templates_default_td-agent-ui.erb
             templates_default_td-agent-ui.service.erb
             templates_default_kibana.yml.erb
             templates_default_jenkins.erb
            ]

            chef_erb_template_files.each do |file|
              expect(Pathname.new(chef_dir + file)).to exist
            end
          end

          it 'create build sh files' do
            sh_dir = Pathname.new(dir[:env_src_build_dir] + 'sh')
            expect(sh_dir).to exist

            sh_files = %w[
          build.sh
          ]

            sh_files.each do |file|
              expect(Pathname.new(sh_dir + file)).to exist
            end
          end

          it 'create ship capistrano files' do
            cap_dir = Pathname.new(dir[:env_src_ship_dir] + 'capistrano')
            cap_puma_dir = Pathname.new(cap_dir + 'puma')
            cap_tasks_dir = Pathname.new(cap_dir + 'tasks')
            cap_td_agent_dir = Pathname.new(cap_dir + 'td-agent')
            expect(cap_dir).to exist
            expect(cap_puma_dir).to exist
            expect(cap_tasks_dir).to exist
            expect(cap_td_agent_dir).to exist

            cap_puma_files = %w[
             Capfile
             deploy.rb
             development.rb
             maintenance.html.erb
           ]
            cap_tasks_files = %w[
             active_job.rake
             db.rake
             puma.rake
             td-agent.rake
           ]
            cap_td_agent_files = %w[
             fluent-logger.yml
             td-agent.conf
           ]

            cap_puma_files.each do |file|
              expect(Pathname.new(cap_puma_dir + file)).to exist
            end
            cap_tasks_files.each do |file|
              expect(Pathname.new(cap_tasks_dir + file)).to exist
            end
            cap_td_agent_files.each do |file|
              expect(Pathname.new(cap_td_agent_dir + file)).to exist
            end
          end

          it 'create ship sh files' do
            sh_dir = Pathname.new(dir[:env_src_ship_dir] + 'sh')
            expect(sh_dir).to exist

            sh_files = %w[
          ship.sh
          ]

            sh_files.each do |file|
              expect(Pathname.new(sh_dir + file)).to exist
            end
          end

          it 'create ship vagrant files' do
            vagrant_dir = Pathname.new(dir[:env_src_ship_dir] + 'vagrant')
            expect(vagrant_dir).to exist

            vagrant_files = %w[
             create_box.sh
             metadata.json
            ]

            vagrant_files.each do |file|
              expect(Pathname.new(vagrant_dir + file)).to exist
            end
          end

          it 'create run config files' do
            config_dir = Pathname.new(dir[:env_src_run_dir] + 'config')
            expect(config_dir).to exist

            config_files = %w[
             schedule.rb
             sidekiq.rb
             sidekiq.yml
            ]

            config_files.each do |file|
              expect(Pathname.new(config_dir + file)).to exist
            end
          end

          it 'create run rake files' do
            rake_dir = Pathname.new(dir[:env_src_run_dir] + 'rake')
            expect(rake_dir).to exist

            rake_files = %w[
           db.rake
          ]

            rake_files.each do |file|
              expect(Pathname.new(rake_dir + file)).to exist
            end
          end

          it 'create run sh files' do
            sh_dir = Pathname.new(dir[:env_src_run_dir] + 'sh')
            expect(sh_dir).to exist

            sh_files = %w[
             run.sh
            ]

            sh_files.each do |file|
              expect(Pathname.new(sh_dir + file)).to exist
            end
          end
        end

        describe '#create_aws_ruby_staging_env' do
          it 'create staging environment'
        end

        describe '#create_aws_ruby_production_env' do
          it 'create production environment'
        end

        describe '#create_aws_ruby_share_env' do
          it 'create production environment'
        end
      end
    end
  end
end
