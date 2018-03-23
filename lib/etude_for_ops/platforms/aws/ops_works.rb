module EtudeForOps
  class OpsWorks < Platform
    def initialize(platform)
      @platform = platform
    end

    def build
      create_build_files
    end

    def ship
      create_ship_files
    end

    def run
      create_run_files
    end

    private

    def src_build_dir
      "#{@platform.src_build_dir}/aws/opsworks"
    end

    def src_ship_dir
      "#{@platform.src_ship_dir}/aws/opsworks"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/aws/opsworks/#{file}.erb"
    end

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/99_share/platform/aws/opsworks/#{file}.erb"
    end

    def create_build_files
      FileUtils.mkdir_p(src_build_dir, mode: 0o755)

      erb_files = %w[
        opsworks.yml
        opsworks_create_stack.sh
        opsworks_update_stack.sh
      ]

      params = {}
      if @platform.params[:env] == 'Development'
      end

      if @platform.params[:env] == 'Staging'
        params[:application_name] = @platform.params[:application_name]
        params[:application_name_short] = @platform.params[:application_name].downcase
        params[:opsw_cookbook_password] = @platform.params[:opsw_cookbook_password]
        params[:opsw_cookbook_type] = @platform.params[:opsw_cookbook_type]
        params[:opsw_cookbook_url] = @platform.params[:opsw_cookbook_url]
        params[:opsw_cookbook_username] = @platform.params[:opsw_cookbook_username]
        params[:opsw_az_1] = @platform.params[:opsw_az_1]
        params[:opsw_os] = @platform.params[:opsw_os]
        params[:opsw_ec2_instance_class] = @platform.params[:opsw_ec2_instance_class]
        params[:opsw_elb_name] = @platform.params[:opsw_elb_name]
        params[:opsw_elb_cert_arn] = @platform.params[:opsw_elb_cert_arn]
        params[:opsw_elb_subnet_1] = @platform.params[:opsw_elb_subnet_1]
        params[:opsw_elb_subnet_2] = @platform.params[:opsw_elb_subnet_2]

        params[:cfm_opsw_stackname] = 'STG_CFM_OPSW_STACKNAME'
        params[:opsw_stackname] = 'STG_OPSW_STACKNAME'
        params[:opsw_template] = 'STG_OPSW_TEMPLATE'
        params[:opsw_tagkey] = 'STG_TAGKEY'
        params[:opsw_tagvalue] = 'STG_TAGVALUE'
        params[:opsw_vpc_id] = 'STG_VPC_ID'
        params[:opsw_subnet_pub_1] = 'STG_OPSW_SUBNET_PUB_1'
        params[:opsw_subnet_pub_2] = 'STG_OPSW_SUBNET_PUB_2'
        params[:opsw_subnet_pri_1] = 'STG_OPSW_SUBNET_PRI_1'
        params[:opsw_subnet_pri_2]= 'STG_OPSW_SUBNET_PRI_2'
        params[:opsw_keyname] = 'STG_OPSW_KEYNAME'
        params[:opsw_elb_name] = 'STG_OPSW_ELB_NAME'
        params[:opsw_elb_cert_arn] = 'STG_OPSW_ELB_CERT_ARN'
      end

      if @platform.params[:env] == 'Production'
        params[:application_name] = @platform.params[:application_name]
        params[:application_name_short] = @platform.params[:application_name].downcase
        params[:opsw_cookbook_password] = @platform.params[:opsw_cookbook_password]
        params[:opsw_cookbook_type] = @platform.params[:opsw_cookbook_type]
        params[:opsw_cookbook_url] = @platform.params[:opsw_cookbook_url]
        params[:opsw_cookbook_username] = @platform.params[:opsw_cookbook_username]
        params[:opsw_az_1] = @platform.params[:opsw_az_1]
        params[:opsw_os] = @platform.params[:opsw_os]
        params[:opsw_ec2_instance_class] = @platform.params[:opsw_ec2_instance_class]

        params[:cfm_opsw_stackname] = 'PRD_CFM_OPSW_STACKNAME'
        params[:opsw_stackname] = 'PRD_OPSW_STACKNAME'
        params[:opsw_template] = 'PRD_OPSW_TEMPLATE'
        params[:opsw_tagkey] = 'PRD_TAGKEY'
        params[:opsw_tagvalue] = 'PRD_TAGVALUE'
        params[:opsw_vpc_id] = 'PRD_VPC_ID'
        params[:opsw_subnet_pub_1] = 'PRD_OPSW_SUBNET_PUB_1'
        params[:opsw_subnet_pub_2] = 'PRD_OPSW_SUBNET_PUB_2'
        params[:opsw_subnet_pri_1] = 'PRD_OPSW_SUBNET_PRI_1'
        params[:opsw_subnet_pri_2]= 'PRD_OPSW_SUBNET_PRI_2'
        params[:opsw_keyname] = 'PRD_OPSW_KEYNAME'
        params[:opsw_elb_name] = 'PRD_OPSW_ELB_NAME'
        params[:opsw_elb_cert_arn] = 'PRD_OPSW_ELB_CERT_ARN'
      end

      create_put_bind_template_files(src_build_dir,erb_files,params)
    end

    def create_ship_files
      FileUtils.mkdir_p(src_ship_dir, mode: 0o755)

      erb_files = %w[
        opsworks_deploy_cookbook.sh
        opsworks_update_app.sh
        opsworks_update_app_without_rds.sh
        opsworks_update_app_job.sh
        opsworks_update_app_job_without_rds.sh
        opsworks_update_app_api.sh
        opsworks_update_app_api_without_rds.sh
        opsworks_update_app_bot.sh
        opsworks_create_elb.sh
        opsworks_create_instance.sh
        opsworks_deploy_app.sh
        opsworks_register_eip.sh
        opsworks_register_rds.sh
        opsworks_update_instance.sh
        opsworks_update_layer.sh
      ]

      params = {}
      if @platform.params[:env] == 'Development'
      end

      if @platform.params[:env] == 'Staging'
        params[:opsw_app_id] = 'STG_OPSW_APP_ID'
        params[:opsw_app_job_id] = 'STG_OPSW_APP_JOB_ID'
        params[:opsw_app_api_id] = 'STG_OPSW_APP_API_ID'
        params[:opsw_app_bot_id] = 'STG_OPSW_APP_BOT_ID'
        params[:opsw_rds_db_instance_arn] = 'STG_OPSW_RDS_DB_INSTANCE_ARN'
        params[:opsw_rds_db_name] = 'STG_RDS_DB_NAME'
        params[:opsw_rds_db_username] = 'STG_RDS_DB_USER_NAME'
        params[:opsw_rds_db_password] = 'STG_RDS_DB_PASSWORD'
        params[:opsw_db_name] = 'STG_DB_NAME'
        params[:opsw_app_env] = 'STG_APP_ENV'
        params[:opsw_app_secret_key_base] = 'STG_APP_SECRET_KEY_BASE'
        params[:opsw_db_adapter] = 'STG_OPSW_DB_ADAPTER'
        params[:opsw_db_name] = 'STG_OPSW_DB_NAME'
        params[:opsw_db_job_name] = 'STG_OPSW_DB_JOB_NAME'
        params[:opsw_db_api_name] = 'STG_OPSW_DB_API_NAME'
        params[:opsw_db_username] = 'STG_OPSW_DB_USERNAME'
        params[:opsw_db_password] = 'STG_OPSW_DB_PASSWORD'
        params[:opsw_db_hostname] = 'STG_OPSW_DB_HOSTNAME'
        params[:opsw_db_port] = 'STG_OPSW_DB_PORT'
        params[:opsw_backet] = 'STG_S3_BACKET'
        params[:opsw_app_url] = 'STG_OPSW_APP_URL'
        params[:opsw_app_revision] = 'STG_OPSW_APP_REVISION'
        params[:opsw_app_repo_url] = 'STG_OPSW_APP_REPO_URL'
        params[:opsw_app_job_url] = 'STG_OPSW_APP_JOB_URL'
        params[:opsw_app_job_revision] = 'STG_OPSW_APP_JOB_REVISION'
        params[:opsw_app_job_repo_url] = 'STG_OPSW_APP_JOB_REPO_URL'
        params[:opsw_app_api_url] = 'STG_OPSW_APP_API_URL'
        params[:opsw_app_api_revision] = 'STG_OPSW_APP_API_REVISION'
        params[:opsw_app_api_repo_url] = 'STG_OPSW_APP_API_REPO_URL'
        params[:opsw_app_bot_url] = 'STG_OPSW_APP_BOT_URL'
        params[:opsw_app_bot_revision] = 'STG_OPSW_APP_BOT_REVISION'
        params[:opsw_app_bot_repo_url] = 'STG_OPSW_APP_BOT_REPO_URL'

        params[:opsw_elb_subnet_1] = 'STG_OPSW_ELB_SUBNET_1'
        params[:opsw_elb_subnet_2] = 'STG_OPSW_ELB_SUBNET_2'
        params[:opsw_elb_name] = 'STG_OPSW_ELB_NAME'
        params[:opsw_ssl_cert] = 'STG_OPSW_SSL_CERT'
        params[:opsw_app_layer_id] = 'STG_OPSW_APP_LAYER_ID'
        params[:opsw_app_layer_sg] = 'STG_OPSW_APP_LAYER_SG'

        params[:cfm_opsw_stackname] = 'STG_CFM_OPSW_STACKNAME'
        params[:opsw_stackname] = 'STG_OPSW_STACKNAME'
        params[:opsw_template] = 'STG_OPSW_TEMPLATE'
        params[:opsw_tagkey] = 'STG_TAGKEY'
        params[:opsw_tagvalue] = 'STG_TAGVALUE'
        params[:opsw_vpc_id] = 'STG_VPC_ID'
        params[:opsw_subnet_pub_1] = 'STG_OPSW_SUBNET_PUB_1'
        params[:opsw_subnet_pub_2] = 'STG_OPSW_SUBNET_PUB_2'
        params[:opsw_subnet_pri_1] = 'STG_OPSW_SUBNET_PRI_1'
        params[:opsw_subnet_pri_2]= 'STG_OPSW_SUBNET_PRI_2'
        params[:opsw_keyname] = 'STG_OPSW_KEYNAME'
        params[:opsw_ssl_cert] = 'STG_OPSW_SSL_CERT'

        params[:opsw_stack_id] = 'STG_OPSW_STACK_ID'
        params[:opsw_app_id] =  'STG_OPSW_APP_ID'
        params[:opsw_eip] = 'STG_OPSW_EIP'
        params[:opsw_rds_db_instance_arn] = 'STG_OPSW_DB_INSTANCE_ARN'
        params[:opsw_db_user] = 'STG_OPSW_DB_USERNAME'
        params[:opsw_db_password] = 'STG_OPSW_DB_PASSWORD'

        params[:opsw_instance_id] = 'STG_OPSW_INSTANCE_ID'
        params[:opsw_eip] = 'STG_OPSW_EIP'

        params[:opsw_setup_recipe] = 'STG_OPSW_SETUP_RECIPE'
        params[:opsw_configure_recipe] = 'STG_OPSW_CONFIGURE_RECIPE'
        params[:opsw_deploy_recipe] = 'STG_OPSW_DEPLOY_RECIPE'
        params[:opsw_undeploy_recipe] = 'STG_OPSW_UNDEPLOY_RECIPE'
        params[:opsw_shutdown_recipe] = 'STG_OPSW_SHUTDOWN_RECIPE'
        params[:opsw_ec2_instance_class] = 'STG_OPSW_INSTANCE_TYPE'
        params[:opsw_os] = 'STG_OPSW_OS'

        params[:opsw_s3_access_key] = 'AWS_ACCESS_KEY_ID'
        params[:opsw_s3_secret_key] = 'AWS_SECRET_ACCESS_KEY'

      end

      if @platform.params[:env] == 'Production'
        params[:opsw_app_id] = 'PRD_OPSW_APP_ID'
        params[:opsw_app_job_id] = 'PRD_OPSW_APP_JOB_ID'
        params[:opsw_app_api_id] = 'PRD_OPSW_APP_API_ID'
        params[:opsw_app_bot_id] = 'PRD_OPSW_APP_BOT_ID'
        params[:opsw_rds_db_instance_arn] = 'PRD_OPSW_RDS_DB_INSTANCE_ARN'
        params[:opsw_rds_db_name] = 'PRD_RDS_DB_NAME'
        params[:opsw_rds_db_username] = 'PRD_RDS_DB_USER_NAME'
        params[:opsw_rds_db_password] = 'PRD_RDS_DB_PASSWORD'
        params[:opsw_db_name] = 'PRD_DB_NAME'
        params[:opsw_app_env] = 'PRD_APP_ENV'
        params[:opsw_app_secret_key_base] = 'PRD_APP_SECRET_KEY_BASE'
        params[:opsw_db_adapter] = 'PRD_OPSW_DB_ADAPTER'
        params[:opsw_db_name] = 'PRD_OPSW_DB_NAME'
        params[:opsw_db_job_name] = 'PRD_OPSW_DB_JOB_NAME'
        params[:opsw_db_api_name] = 'PRD_OPSW_DB_API_NAME'
        params[:opsw_db_username] = 'PRD_OPSW_DB_USERNAME'
        params[:opsw_db_password] = 'PRD_OPSW_DB_PASSWORD'
        params[:opsw_db_hostname] = 'PRD_OPSW_DB_HOSTNAME'
        params[:opsw_db_port] = 'PRD_OPSW_DB_PORT'
        params[:opsw_backet] = 'PRD_S3_BACKET'
        params[:opsw_app_url] = 'PRD_OPSW_APP_URL'
        params[:opsw_app_revision] = 'PRD_OPSW_APP_REVISION'
        params[:opsw_app_repo_url] = 'PRD_OPSW_APP_REPO_URL'
        params[:opsw_app_job_url] = 'PRD_OPSW_APP_JOB_URL'
        params[:opsw_app_job_revision] = 'PRD_OPSW_APP_JOB_REVISION'
        params[:opsw_app_job_repo_url] = 'PRD_OPSW_APP_JOB_REPO_URL'
        params[:opsw_app_api_url] = 'PRD_OPSW_APP_API_URL'
        params[:opsw_app_api_revision] = 'PRD_OPSW_APP_API_REVISION'
        params[:opsw_app_api_repo_url] = 'PRD_OPSW_APP_API_REPO_URL'
        params[:opsw_app_bot_url] = 'PRD_OPSW_APP_BOT_URL'
        params[:opsw_app_bot_revision] = 'PRD_OPSW_APP_BOT_REVISION'
        params[:opsw_app_bot_repo_url] = 'PRD_OPSW_APP_BOT_REPO_URL'

        params[:opsw_elb_subnet_1] = 'PRD_OPSW_ELB_SUBNET_1'
        params[:opsw_elb_subnet_2] = 'PRD_OPSW_ELB_SUBNET_2'
        params[:opsw_elb_name] = 'PRD_OPSW_ELB_NAME'
        params[:opsw_ssl_cert] = 'PRD_OPSW_SSL_CERT'
        params[:opsw_app_layer_id] = 'PRD_OPSW_APP_LAYER_ID'
        params[:opsw_app_layer_sg] = 'PRD_OPSW_APP_LAYER_SG'

        params[:cfm_opsw_stackname] = 'PRD_CFM_OPSW_STACKNAME'
        params[:opsw_stackname] = 'PRD_OPSW_STACKNAME'
        params[:opsw_template] = 'PRD_OPSW_TEMPLATE'
        params[:opsw_tagkey] = 'PRD_TAGKEY'
        params[:opsw_tagvalue] = 'PRD_TAGVALUE'
        params[:opsw_vpc_id] = 'PRD_VPC_ID'
        params[:opsw_subnet_pub_1] = 'PRD_OPSW_SUBNET_PUB_1'
        params[:opsw_subnet_pub_2] = 'PRD_OPSW_SUBNET_PUB_2'
        params[:opsw_subnet_pri_1] = 'PRD_OPSW_SUBNET_PRI_1'
        params[:opsw_subnet_pri_2]= 'PRD_OPSW_SUBNET_PRI_2'
        params[:opsw_keyname] = 'PRD_OPSW_KEYNAME'
        params[:opsw_ssl_cert] = 'PRD_OPSW_SSL_CERT'

        params[:opsw_stack_id] = 'PRD_OPSW_STACK_ID'
        params[:opsw_app_id] =  'PRD_OPSW_APP_ID'
        params[:opsw_eip] = 'PRD_OPSW_EIP'
        params[:opsw_rds_db_instance_arn] = 'PRD_OPSW_DB_INSTANCE_ARN'
        params[:opsw_db_user] = 'PRD_OPSW_DB_USERNAME'
        params[:opsw_db_password] = 'PRD_OPSW_DB_PASSWORD'

        params[:opsw_instance_id] = 'PRD_OPSW_INSTANCE_ID'
        params[:opsw_eip] = 'PRD_OPSW_EIP'

        params[:opsw_setup_recipe] = 'PRD_OPSW_SETUP_RECIPE'
        params[:opsw_configure_recipe] = 'PRD_OPSW_CONFIGURE_RECIPE'
        params[:opsw_deploy_recipe] = 'PRD_OPSW_DEPLOY_RECIPE'
        params[:opsw_undeploy_recipe] = 'PRD_OPSW_UNDEPLOY_RECIPE'
        params[:opsw_shutdown_recipe] = 'PRD_OPSW_SHUTDOWN_RECIPE'
        params[:opsw_ec2_instance_class] = 'PRD_OPSW_INSTANCE_TYPE'
        params[:opsw_os] = 'PRD_OPSW_OS'

        params[:opsw_s3_access_key] = 'AWS_ACCESS_KEY_ID'
        params[:opsw_s3_secret_key] = 'AWS_SECRET_ACCESS_KEY'

      end

      create_put_bind_template_files(src_ship_dir,erb_files,params)
    end

    def create_run_files

    end
  end
end
