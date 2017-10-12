module EtudeForOps
  class AWS < Platform
    def template_root_path
      "#{Cloud::TEMPLATE_ROOT_PAHT}/aws"
    end

    def get_template_params(params,config)
      params[:strategy] = 'cloud_aws'
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
  end
end
