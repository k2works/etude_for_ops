module EtudeForOps
  class AWS < Platform
    def initialize(env=nil)
      super
      unless env.nil?
        env.template_root_path = "#{Cloud::TEMPLATE_ROOT_PAHT}/aws"
        @tmp_file_dir = env.tmp_file_dir
      end
    end


    def template_root_path
      "#{Cloud::TEMPLATE_ROOT_PAHT}/aws"
    end

    def get_template_params(params,config)
      params[:strategy] = 'cloud_aws'

      if params[:env] == 'Development'
        params[:application_name] = "#{config['ops']['share']['application']['name']}Development"

        params[:default_az1] = config['ops']['development']['aws_az_1']
        params[:default_az2] = config['ops']['development']['aws_az_2']
        params[:vpc_id] = config['ops']['development']['vpc_id']
        params[:rds_subnet_1] = config['ops']['development']['rds_subnet_1']
        params[:rds_subnet_2] = config['ops']['development']['rds_subnet_2']
        params[:rds_engine] = config['ops']['development']['rds_engine']
        params[:rds_engine_version] = config['ops']['development']['rds_engine_version']
        params[:rds_db_parameter_group_family] = config['ops']['development']['rds_db_parameter_group_family']
        params[:rds_db_instance_name] = config['ops']['development']['rds_db_instance_name']
        params[:rds_db_name] = config['ops']['development']['rds_db_name']
        params[:rds_db_user_name] = config['ops']['development']['rds_db_user_name']
        params[:rds_db_password] = config['ops']['development']['rds_db_password']
        params[:rds_db_class] = config['ops']['development']['rds_db_class']
        params[:rds_db_allocated_storage] = config['ops']['development']['rds_db_allocated_storage']
      end

      if params[:env] == 'Staging'
        params[:application_name] = "#{config['ops']['share']['application']['name']}Staging"

        params[:default_az1] = config['ops']['staging']['aws_az_1']
        params[:default_az2] = config['ops']['staging']['aws_az_2']
        params[:vpc_id] = config['ops']['staging']['vpc_id']
        params[:rds_subnet_1] = config['ops']['staging']['rds_subnet_1']
        params[:rds_subnet_2] = config['ops']['staging']['rds_subnet_2']
        params[:rds_engine] = config['ops']['staging']['rds_engine']
        params[:rds_engine_version] = config['ops']['staging']['rds_engine_version']
        params[:rds_db_parameter_group_family] = config['ops']['staging']['rds_db_parameter_group_family']
        params[:rds_db_instance_name] = config['ops']['staging']['rds_db_instance_name']
        params[:rds_db_name] = config['ops']['staging']['rds_db_name']
        params[:rds_db_user_name] = config['ops']['staging']['rds_db_user_name']
        params[:rds_db_password] = config['ops']['staging']['rds_db_password']
        params[:rds_db_class] = config['ops']['staging']['rds_db_class']
        params[:rds_db_allocated_storage] = config['ops']['staging']['rds_db_allocated_storage']

        params[:opsw_cookbook_password] = config['ops']['staging']['opsw_cookbook_password']
        params[:opsw_cookbook_type] = config['ops']['staging']['opsw_cookbook_type']
        params[:opsw_cookbook_url] = config['ops']['staging']['opsw_cookbook_url']
        params[:opsw_cookbook_username] = config['ops']['staging']['opsw_cookbook_username']
        params[:opsw_az_1] = config['ops']['staging']['aws_az_1']
        params[:opsw_app_ssh_key] = config['ops']['staging']['opsw_app_ssh_key']
        params[:opsw_app_repo_url] = config['ops']['staging']['opsw_app_repo_url']
        params[:opsw_app_repo_revision] = config['ops']['staging']['opsw_app_repo_revison']
        params[:opsw_app_domain] = config['ops']['staging']['opsw_app_domain']
        params[:opsw_app_ssl_cert] = config['ops']['staging']['opsw_app_ssl_cert']
        params[:opsw_app_ssl_private_key] = config['ops']['staging']['opsw_app_ssl_private_key']
      end
    end
  end
end
