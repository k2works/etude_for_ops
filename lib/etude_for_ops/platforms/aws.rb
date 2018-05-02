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
        params[:organization_name] = "#{config['ops']['share']['organization']}"
        params[:application_name] = "#{config['ops']['share']['application']['name']}"
        params[:aws_default_region] = config['ops']['staging']['aws_default_region']

        params[:default_az1] = config['ops']['development']['aws_az_1']
        params[:default_az2] = config['ops']['development']['aws_az_2']
        params[:iam_user_group] = config['ops']['development']['iam_user_group']
        params[:iam_user_name] = config['ops']['development']['iam_user_name']
        params[:iam_user_password] = config['ops']['development']['iam_user_password']
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

        params[:opsw_cookbook_password] = config['ops']['development']['opsw_cookbook_password']
        params[:opsw_cookbook_type] = config['ops']['development']['opsw_cookbook_type']
        params[:opsw_cookbook_url] = config['ops']['development']['opsw_cookbook_url']
        params[:opsw_cookbook_username] = config['ops']['development']['opsw_cookbook_username']
        params[:opsw_az_1] = config['ops']['development']['aws_az_1']
        params[:opsw_os] = config['ops']['development']['opsw_os']
        params[:opsw_ec2_instance_class] = config['ops']['development']['opsw_ec2_instance_class']
        params[:opsw_elb_name] = config['ops']['development']['opsw_elb_name']
        params[:opsw_elb_cert_arn] = config['ops']['development']['opsw_elb_cert_arn']
        params[:opsw_elb_subnet_1] = config['ops']['development']['opsw_elb_subnet_1']
        params[:opsw_elb_subnet_2] = config['ops']['development']['opsw_elb_subnet_2']

        params[:code_build_project_name] = config['ops']['development']['codebuild_project_name']
        params[:code_build_source_type] = config['ops']['development']['codebuild_source_type']
        params[:code_build_source_location] = config['ops']['development']['codebuild_source_location']
        params[:code_build_region_id] = config['ops']['development']['aws_default_region']
        params[:code_build_account_id] = config['ops']['development']['iam_account_id']
        params[:code_build_bucket_file_name] = "#{config['ops']['share']['application']['name']}Development"
        params[:amazon_ecr_repo_name] = "#{config['ops']['share']['ecr_repository']}-development"
        params[:role_name] = config['ops']['development']['codebuild_rol_name']

        params[:codepipeline_account_id] = config['ops']['development']['iam_account_id']
        params[:codepipeline_name] = config['ops']['development']['codepipeline_name']
        params[:codepipeline_artifactstore_location] = config['ops']['development']['codepipeline_artifactstore_location']
        params[:codepipeline_deploy_name] = config['ops']['development']['codepipeline_deploy_name']
        params[:codepipeline_deploy_application_name] = config['ops']['development']['codepipeline_deploy_application_name']
        params[:codepipeline_deploy_deploymentgroup_name] = config['ops']['development']['codepipeline_deploy_deploymentgroup_name']
        params[:codepipeline_build_name] = config['ops']['development']['codepipeline_build_name']
        params[:codepipeline_build_project_name] = config['ops']['development']['codepipeline_build_project_name']
        params[:codepipeline_source_name] = config['ops']['development']['codepipeline_source_name']
        params[:codepipeline_source_oauthtoken] = config['ops']['development']['codepipeline_source_oauthtoken']
      end

      if params[:env] == 'Staging'
        params[:organization_name] = "#{config['ops']['share']['organization']}"
        params[:application_name] = "#{config['ops']['share']['application']['name']}"
        params[:aws_default_region] = config['ops']['staging']['aws_default_region']

        params[:default_az1] = config['ops']['staging']['aws_az_1']
        params[:default_az2] = config['ops']['staging']['aws_az_2']
        params[:iam_user_group] = config['ops']['staging']['iam_user_group']
        params[:iam_user_name] = config['ops']['staging']['iam_user_name']
        params[:iam_user_password] = config['ops']['staging']['iam_user_password']
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
        params[:opsw_elb_name] = config['ops']['staging']['opsw_elb_name']
        params[:opsw_elb_cert_arn] = config['ops']['staging']['opsw_elb_cert_arn']
        params[:opsw_elb_subnet_1] = config['ops']['staging']['opsw_elb_subnet_1']
        params[:opsw_elb_subnet_2] = config['ops']['staging']['opsw_elb_subnet_2']

        params[:code_build_project_name] = config['ops']['staging']['codebuild_project_name']
        params[:code_build_source_type] = config['ops']['staging']['codebuild_source_type']
        params[:code_build_source_location] = config['ops']['staging']['codebuild_source_location']
        params[:code_build_region_id] = config['ops']['staging']['aws_default_region']
        params[:code_build_account_id] = config['ops']['staging']['iam_account_id']
        params[:code_build_bucket_file_name] = "#{config['ops']['share']['application']['name']}Development"
        params[:amazon_ecr_repo_name] = "#{config['ops']['share']['ecr_repository']}-staging"
        params[:role_name] = config['ops']['staging']['codebuild_rol_name']

        params[:codepipeline_account_id] = config['ops']['staging']['iam_account_id']
        params[:codepipeline_name] = config['ops']['staging']['codepipeline_name']
        params[:codepipeline_artifactstore_location] = config['ops']['staging']['codepipeline_artifactstore_location']
        params[:codepipeline_deploy_name] = config['ops']['staging']['codepipeline_deploy_name']
        params[:codepipeline_deploy_application_name] = config['ops']['staging']['codepipeline_deploy_application_name']
        params[:codepipeline_deploy_deploymentgroup_name] = config['ops']['staging']['codepipeline_deploy_deploymentgroup_name']
        params[:codepipeline_build_name] = config['ops']['staging']['codepipeline_build_name']
        params[:codepipeline_build_project_name] = config['ops']['staging']['codepipeline_build_project_name']
        params[:codepipeline_source_name] = config['ops']['staging']['codepipeline_source_name']
        params[:codepipeline_source_oauthtoken] = config['ops']['staging']['codepipeline_source_oauthtoken']
      end

      if params[:env] == 'Production'
        params[:organization_name] = "#{config['ops']['share']['organization']}"
        params[:application_name] = "#{config['ops']['share']['application']['name']}"
        params[:aws_default_region] = config['ops']['staging']['aws_default_region']

        params[:default_az1] = config['ops']['production']['aws_az_1']
        params[:default_az2] = config['ops']['production']['aws_az_2']
        params[:iam_user_group] = config['ops']['production']['iam_user_group']
        params[:iam_user_name] = config['ops']['production']['iam_user_name']
        params[:iam_user_password] = config['ops']['production']['iam_user_password']
        params[:vpc_id] = config['ops']['production']['vpc_id']
        params[:rds_subnet_1] = config['ops']['production']['rds_subnet_1']
        params[:rds_subnet_2] = config['ops']['production']['rds_subnet_2']
        params[:rds_engine] = config['ops']['production']['rds_engine']
        params[:rds_engine_version] = config['ops']['production']['rds_engine_version']
        params[:rds_db_parameter_group_family] = config['ops']['production']['rds_db_parameter_group_family']
        params[:rds_db_instance_name] = config['ops']['production']['rds_db_instance_name']
        params[:rds_db_name] = config['ops']['production']['rds_db_name']
        params[:rds_db_user_name] = config['ops']['production']['rds_db_user_name']
        params[:rds_db_password] = config['ops']['production']['rds_db_password']
        params[:rds_db_class] = config['ops']['production']['rds_db_class']
        params[:rds_db_allocated_storage] = config['ops']['production']['rds_db_allocated_storage']

        params[:opsw_cookbook_password] = config['ops']['production']['opsw_cookbook_password']
        params[:opsw_cookbook_type] = config['ops']['production']['opsw_cookbook_type']
        params[:opsw_cookbook_url] = config['ops']['production']['opsw_cookbook_url']
        params[:opsw_cookbook_username] = config['ops']['production']['opsw_cookbook_username']
        params[:opsw_az_1] = config['ops']['production']['aws_az_1']
        params[:opsw_os] = config['ops']['production']['opsw_os']
        params[:opsw_ec2_instance_class] = config['ops']['production']['opsw_ec2_instance_class']
        params[:opsw_elb_name] = config['ops']['production']['opsw_elb_name']
        params[:opsw_elb_cert_arn] = config['ops']['production']['opsw_elb_cert_arn']
        params[:opsw_elb_subnet_1] = config['ops']['production']['opsw_elb_subnet_1']
        params[:opsw_elb_subnet_2] = config['ops']['production']['opsw_elb_subnet_2']

        params[:code_build_project_name] = config['ops']['production']['codebuild_project_name']
        params[:code_build_source_type] = config['ops']['production']['codebuild_source_type']
        params[:code_build_source_location] = config['ops']['production']['codebuild_source_location']
        params[:code_build_region_id] = config['ops']['production']['aws_default_region']
        params[:code_build_account_id] = config['ops']['production']['iam_account_id']
        params[:code_build_bucket_file_name] = "#{config['ops']['share']['application']['name']}Development"
        params[:amazon_ecr_repo_name] = "#{config['ops']['share']['ecr_repository']}-production"
        params[:role_name] = config['ops']['production']['codebuild_rol_name']

        params[:codepipeline_account_id] = config['ops']['production']['iam_account_id']
        params[:codepipeline_name] = config['ops']['production']['codepipeline_name']
        params[:codepipeline_artifactstore_location] = config['ops']['production']['codepipeline_artifactstore_location']
        params[:codepipeline_deploy_name] = config['ops']['production']['codepipeline_deploy_name']
        params[:codepipeline_deploy_application_name] = config['ops']['production']['codepipeline_deploy_application_name']
        params[:codepipeline_deploy_deploymentgroup_name] = config['ops']['production']['codepipeline_deploy_deploymentgroup_name']
        params[:codepipeline_build_name] = config['ops']['production']['codepipeline_build_name']
        params[:codepipeline_build_project_name] = config['ops']['production']['codepipeline_build_project_name']
        params[:codepipeline_source_name] = config['ops']['production']['codepipeline_source_name']
        params[:codepipeline_source_oauthtoken] = config['ops']['production']['codepipeline_source_oauthtoken']
      end
    end
  end
end
