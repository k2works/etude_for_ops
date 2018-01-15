module EtudeForOps
  class AWS < Platform

    def initialize(env=nil)
      super
      unless env.nil?
        env.template_root_path = "#{Cloud::TEMPLATE_ROOT_PAHT}/aws"
        @tmp_file_dir = env.tmp_file_dir
        @tmp_share_file_dir = "#{Cloud::COMMON_TEMPLATE_ROOT_PAHT}/aws"
      end
    end


    def template_root_path
      "#{Cloud::TEMPLATE_ROOT_PAHT}/aws"
    end

    def get_template_params(params,config)
      params[:strategy] = 'cloud_aws'

      if params[:env] == 'Development'
        params[:application_name] = "#{config['ops']['share']['application']['name']}"

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
        params[:application_name] = "#{config['ops']['share']['application']['name']}"

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
        params[:opsw_os] = config['ops']['staging']['opsw_os']
        params[:opsw_ec2_instance_class] = config['ops']['staging']['opsw_ec2_instance_class']
      end
    end
  end
end
