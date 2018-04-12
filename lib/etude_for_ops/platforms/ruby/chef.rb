module EtudeForOps
  class Chef < Ruby
    def initialize(platform)
      @platform = platform
    end

    def build
      create_dir
      create_files
      create_erb_template_files
    end

    def ship

    end

    def run

    end

    private

    def create_dir
      FileUtils.mkdir_p(src_build_dir, mode: 0o755)
    end

    def src_build_dir
      "#{@platform.src_build_dir}/chef"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/ruby/chef/#{file}.erb"
    end

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/platform/ruby/chef/#{file}.erb"
    end

    def create_files
      platform_ruby_chef_files = %w[
        attributes_default.rb
        metadata.rb
        provision.json
        ec2_provision.json
        eb_provision.json
        recipes_default.rb
        recipes_ec2.rb
        recipes_ec2_security.rb
        recipes_ec2_agent.rb
        recipes_ec2_ci.rb
        recipes_ec2_log.rb
        recipes_ec2_moni.rb
        recipes_ec2_its.rb
        recipes_ec2_collabo.rb
        recipes_ec2_moni_configure.rb
        recipes_ec2_ci_log_moni_its_collabo_web.rb
        recipes_ec2_ci_log_app_web.rb
　　　　 recipes_ec2_user.rb
        recipes_ec2_app.rb
        recipes_ec2_web.rb
        recipes_ec2_db.rb
        recipes_ec2_bot.rb
        recipes_ec2_configure.rb
        recipes_ec2_job.rb
        recipes_ec2_messaging.rb
        recipes_eb.rb
        recipes_setup.rb
        recipes_configure.rb
        recipes_configure_postgres.rb
        recipes_configure_service.rb
        recipes_configure_mattermost.rb
        recipes_setup_swap.rb
        recipes_setup_ruby.rb
        recipes_setup_mysql.rb
        recipes_setup_mariadb.rb
        recipes_setup_postgres.rb
        recipes_setup_redis.rb
        recipes_setup_mongodb.rb
        recipes_setup_node.rb
        recipes_setup_nginx.rb
        recipes_setup_service.rb
        recipes_setup_td-agent.rb
        recipes_setup_td-agent2.rb
        recipes_setup_elasticsearch.rb
        recipes_setup_docker.rb
        recipes_setup_jenkins.rb
        recipes_setup_jenkins_ec2.rb
        recipes_setup_aws.rb
        recipes_setup_vagrant.rb
        recipes_setup_zabbix.rb
        recipes_setup_jira.rb
        recipes_setup_confluence.rb
        recipes_setup_mattermost.rb
        Vagrantfile
        .kitchen.yml
        Gemfile
        reprovision.sh
        recipes_opsw_deploy.rb
        recipes_opsw_deploy_job.rb
        recipes_opsw_deploy_api.rb
        recipes_opsw_deploy_bot.rb
        recipes_opsw_shutdown.rb
        recipes_opsw_shutdown_job.rb
        recipes_opsw_shutdown_api.rb
        recipes_opsw_shutdown_bot.rb
        recipes_opsw_undeploy.rb
        recipes_opsw_undeploy_api.rb
        recipes_opsw_undeploy_job.rb
        recipes_opsw_undeploy_bot.rb
        recipes_opsw_deploy_rails.rb
        recipes_opsw_deploy_rails_job.rb
        recipes_opsw_deploy_rails_api.rb
        recipes_opsw_deploy_node.rb
        recipes_opsw_undeploy_rails.rb
        recipes_opsw_undeploy_rails_job.rb
        recipes_opsw_undeploy_rails_api.rb
        recipes_opsw_undeploy_node.rb
        recipes_opsw_setup.rb
        recipes_opsw_setup_api.rb
        recipes_opsw_setup_job.rb
        recipes_opsw_setup_bot.rb
        recipes_opsw_setup_ci.rb
        recipes_opsw_setup_log.rb
        recipes_opsw_setup_moni.rb
        recipes_opsw_setup_its.rb
        recipes_opsw_setup_collabo.rb
        recipes_opsw_setup_messaging.rb
        recipes_opsw_configure.rb
        recipes_opsw_configure_api.rb
        recipes_opsw_configure_job.rb
        recipes_opsw_configure_bot.rb
        recipes_opsw_configure_ci.rb
        recipes_opsw_configure_log.rb
        recipes_opsw_configure_moni.rb
        recipes_opsw_configure_its.rb
        recipes_opsw_configure_collabo.rb
        recipes_opsw_configure_messaging.rb
        databag_opsw_app.json
        databag_opsw_job.json
        databag_opsw_api.json
        databag_opsw_bot.json
        databag_opsw_db.json
        files_default_wrap-ssh4git.sh
      ]

      params = {}
      if @platform.params[:env] == 'Development'
        params[:user] = 'vagrant'
        params[:group] = 'vagrant'
        params[:aws_user] = 'ec2-user'
        params[:aws_group] = 'ec2-user'

        params[:ssh_key] = 'DEV_SSH_KEY'

        params[:application_name] = @platform.params[:application_name]
        params[:application_name_short] = @platform.params[:application_name_short]
      end

      if @platform.params[:env] == 'Staging'
        params[:user] = 'ec2-user'
        params[:group] = 'ec2-user'
        params[:aws_user] = 'ec2-user'
        params[:aws_group] = 'ec2-user'

        params[:ssh_key] = 'STG_SSH_KEY'

        params[:application_name] = @platform.params[:application_name]
        params[:application_name_short] = @platform.params[:application_name_short]
      end

      if @platform.params[:env] == 'Production'
        params[:user] = 'ec2-user'
        params[:group] = 'ec2-user'
        params[:aws_user] = 'ec2-user'
        params[:aws_group] = 'ec2-user'

        params[:ssh_key] = 'STG_SSH_KEY'

        params[:application_name] = @platform.params[:application_name]
        params[:application_name_short] = @platform.params[:application_name_short]
      end


      create_put_bind_template_files(src_build_dir,platform_ruby_chef_files, params)
    end

    def create_erb_template_files
      erb_template_files = %w[
        templates_default_banner
        templates_default_bash_profile
        templates_default_bash_profile_aws
        templates_default_bashrc
        templates_default_grants.sql
        templates_default_setup_root.sql
        templates_default_my_extra_settings
        templates_default_nginx.conf
        templates_default_nginx.default.conf
        templates_default_nginx.moni.conf
        templates_default_nginx.proxy.conf
        templates_default_nginx.app.conf
        templates_default_nginx.kibana.conf
        templates_default_nginx.jenkins.conf
        templates_default_nginx.jira.conf
        templates_default_nginx.confluence.conf
        templates_default_nginx.td-agent-ui.conf
        templates_default_nginx.mattermost.conf
        templates_default_puma
        templates_default_puma.service
        templates_default_active_job
        templates_default_active_job.service
        templates_default_td-agent-ui
        templates_default_td-agent-ui.service
        templates_default_td-agent
        templates_default_kibana.yml
        templates_default_jenkins
        templates_default_ssh_config
        templates_default_secure_install.sql
        templates_default_create_db.sql
        templates_default_create_user.sql
        templates_default_ssh_config
        templates_default_postgresql.conf
        templates_default_pg_hba.conf
        templates_default_mongod.conf
        templates_default_redis.conf
        templates_ec2_nginx.default.conf
        templates_ec2_mattermost_nginx.default.conf
        templates_default_database.yml
        templates_default_puma.rb
        templates_default_sidekiq.yml
        templates_default_zabbix_server.conf
        templates_default_kuroko2_foreman
        templates_default_kuroko2_executor
        templates_default_kuroko2_executor.service
        templates_default_kuroko2_processor
        templates_default_kuroko2_processor.service
        templates_default_kuroko2_scheduler
        templates_default_kuroko2_scheduler.service
        templates_default_kuroko2.yml
        templates_default_jira.init
        templates_default_confluence.init
        templates_default_bot_process.json
        templates_default_bot
        templates_default_mattermost
      ]

      create_copy_template_files(src_build_dir,erb_template_files,params)
    end
  end
end
