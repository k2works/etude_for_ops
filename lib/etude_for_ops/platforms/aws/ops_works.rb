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
        opsworks-app.template
        opsworks_create_stack.sh
        opsworks_update_stack.sh
      ]

      params = {}
      if @platform.params[:env] == 'Development'
      end

      if @platform.params[:env] == 'Staging'
        params[:application_name] = @platform.params[:application_name]
        params[:opsw_cookbook_password] = @platform.params[:opsw_cookbook_password]
        params[:opsw_cookbook_type] = @platform.params[:opsw_cookbook_type]
        params[:opsw_cookbook_url] = @platform.params[:opsw_cookbook_url]
        params[:opsw_cookbook_username] = @platform.params[:opsw_cookbook_username]
        params[:opsw_az_1] = @platform.params[:opsw_az_1]
        params[:opsw_os] = @platform.params[:opsw_os]
        params[:opsw_ec2_instance_class] = @platform.params[:opsw_ec2_instance_class]

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
      end


      create_put_bind_template_files(src_build_dir,erb_files,params)
    end

    def create_ship_files
      FileUtils.mkdir_p(src_ship_dir, mode: 0o755)

      erb_files = %w[
        opsworks_deploy_cookbook.sh
        opsworks_update_app.sh
        opsworks_update_app_without_rds.sh
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
        params[:opsw_rds_db_instance_arn] = 'STG_OPSW_RDS_DB_INSTANCE_ARN'
        params[:opsw_rds_db_name] = 'STG_RDS_DB_NAME'
        params[:opsw_rds_db_username] = 'STG_RDS_DB_USER_NAME'
        params[:opsw_rds_db_password] = 'STG_RDS_DB_PASSWORD'
        params[:opsw_db_name] = 'STG_DB_NAME'
        params[:opsw_app_env] = 'STG_APP_ENV'
        params[:opsw_app_secret_key_base] = 'STG_APP_SECRET_KEY_BASE'
        params[:opsw_db_adapter] = 'STG_OPSW_DB_ADAPTER'
        params[:opsw_db_name] = 'STG_OPSW_DB_NAME'
        params[:opsw_db_username] = 'STG_OPSW_DB_USERNAME'
        params[:opsw_db_password] = 'STG_OPSW_DB_PASSWORD'
        params[:opsw_db_hostname] = 'STG_OPSW_DB_HOSTNAME'
        params[:opsw_db_port] = 'STG_OPSW_DB_PORT'
        params[:opsw_app_url] = 'STG_OPSW_APP_URL'
        params[:opsw_backet] = 'BACKET'
        params[:opsw_app_revision] = 'STG_OPSW_APP_REVISION'
        params[:opsw_app_repo_url] = 'STG_OPSW_APP_REPO_URL'

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


      create_put_bind_template_files(src_ship_dir,erb_files,params)
    end

    def create_run_files

    end
  end
end
