module EtudeForOps
  class EB < Platform
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
      "#{@platform.src_build_dir}/aws/eb"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/aws/eb/#{file}.erb"
    end

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/platform/aws/eb/#{file}.erb"
    end

    def create_build_files
      FileUtils.mkdir_p(src_build_dir, mode: 0o755)

      erb_files = %w[
        eb_init.sh
        eb_create_vpc_env.sh
        eb_create_vpc_rds_env.sh
        eb_setenv.sh
      ]

      params = {}
      if @platform.params[:env] == 'Development'
      end

      if @platform.params[:env] == 'Staging'
        params[:eb_application_name] = 'STG_APPLICATION_NAME'
        params[:eb_ssh_key] = 'STG_SSH_KEY_NAME'
        params[:eb_app_platform] = 'STG_EB_APP_PLATFORM'
        params[:eb_region] = 'AWS_DEFAULT_REGION'

        params[:eb_envname] = 'STG_EB_ENVNAME'
        params[:eb_cname] ='STG_EB_CNAME'
        params[:eb_vpc_id] = 'STG_EB_VPC_ID'
        params[:eb_elb_subnet] = 'STG_EB_ELB_SUBNET'
        params[:eb_ec2_subnet] =  'STG_EB_EC2_SUBNET'
        params[:eb_instance] = 'STG_EB_INSTANCE'
        params[:eb_ssh_key_name] = 'STG_SSH_KEY_NAME'
        params[:eb_db_engine] = 'STG_EB_DB_ENGINE'
        params[:eb_db_size] = 'STG_EB_DB_SIZE'
        params[:eb_db_instance] = 'STG_EB_DB_INSTANCE'
        params[:eb_db_password] = 'STG_EB_DB_PASSWORD'
        params[:eb_db_username] = 'STG_EB_DB_USERNAME'
        params[:eb_db_version] = 'STG_EB_DB_VERSION'
        params[:eb_db_subnet_1] = 'STG_EB_DB_SUBNET_1'
        params[:eb_db_subnet_2] = 'STG_EB_DB_SUBNET_2'

        params[:eb_app_env] = 'STG_APP_ENV'
        params[:eb_app_secret_key_base] = 'STG_APP_SECRET_KEY_BASE'
        params[:eb_rds_db_name] = 'STG_RDS_DB_NAME'
        params[:eb_rds_username] = 'STG_RDS_USERNAME'
        params[:eb_rds_password] = 'STG_RDS_PASSWORD'
        params[:eb_rds_hostname] = 'STG_RDS_HOSTNAME'
        params[:eb_rds_port] = 'STG_RDS_PORT'
        params[:eb_url] = 'STG_EB_URL'
        params[:eb_backet] = 'BACKET'
      end


      create_put_bind_template_files(src_build_dir,erb_files,params)
    end

    def create_ship_files

    end

    def create_run_files

    end
  end
end
