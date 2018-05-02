module EtudeForOps
  class CodePipeline < Platform
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

    def src_ship_dir
      "#{@platform.src_ship_dir}/aws/code_pipeline"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/aws/code_pipeline/#{file}.erb"
    end

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/99_share/platform/aws/code_pipeline/#{file}.erb"
    end

    def create_build_files

    end

    def create_ship_files
      FileUtils.mkdir_p(src_ship_dir, mode: 0o755)

      erb_files = %w[
        create-role.json
        put-role-policy.json
        pipeline.json
      ]

      params = {}
      if @platform.params[:env] == 'Development'
        params[:aws_default_region] = @platform.params[:aws_default_region]
        params[:codepipeline_account_id] = @platform.params[:codepipeline_account_id]
        params[:codepipeline_name] = @platform.params[:codepipeline_name]
        params[:codepipeline_artifactstore_location] = @platform.params[:codepipeline_artifactstore_location]
        params[:codepipeline_deploy_name] = @platform.params[:codepipeline_deploy_name]
        params[:codepipeline_deploy_application_name] = @platform.params[:codepipeline_deploy_application_name]
        params[:codepipeline_deploy_deploymentgroup_name] = @platform.params[:codepipeline_deploy_deploymentgroup_name]
        params[:codepipeline_build_name] = @platform.params[:codepipeline_build_name]
        params[:codepipeline_build_project_name] = @platform.params[:codepipeline_build_project_name]
        params[:codepipeline_source_name] = @platform.params[:codepipeline_source_name]
        params[:codepipeline_source_oauthtoken] = @platform.params[:codepipeline_source_oauthtoken]
      end

      if @platform.params[:env] == 'Staging'
        params[:aws_default_region] = @platform.params[:aws_default_region]
        params[:codepipeline_account_id] = @platform.params[:codepipeline_account_id]
        params[:codepipeline_name] = @platform.params[:codepipeline_name]
        params[:codepipeline_artifactstore_location] = @platform.params[:codepipeline_artifactstore_location]
        params[:codepipeline_deploy_name] = @platform.params[:codepipeline_deploy_name]
        params[:codepipeline_deploy_application_name] = @platform.params[:codepipeline_deploy_application_name]
        params[:codepipeline_deploy_deploymentgroup_name] = @platform.params[:codepipeline_deploy_deploymentgroup_name]
        params[:codepipeline_build_name] = @platform.params[:codepipeline_build_name]
        params[:codepipeline_source_name] = @platform.params[:codepipeline_source_name]
        params[:codepipeline_source_oauthtoken] = @platform.params[:codepipeline_source_oauthtoken]
      end

      if @platform.params[:env] == 'Production'
        params[:aws_default_region] = @platform.params[:aws_default_region]
        params[:codepipeline_account_id] = @platform.params[:codepipeline_account_id]
        params[:codepipeline_name] = @platform.params[:codepipeline_name]
        params[:codepipeline_artifactstore_location] = @platform.params[:codepipeline_artifactstore_location]
        params[:codepipeline_deploy_name] = @platform.params[:codepipeline_deploy_name]
        params[:codepipeline_deploy_application_name] = @platform.params[:codepipeline_deploy_application_name]
        params[:codepipeline_deploy_deploymentgroup_name] = @platform.params[:codepipeline_deploy_deploymentgroup_name]
        params[:codepipeline_build_name] = @platform.params[:codepipeline_build_name]
        params[:codepipeline_source_name] = @platform.params[:codepipeline_source_name]
        params[:codepipeline_source_oauthtoken] = @platform.params[:codepipeline_source_oauthtoken]
      end

      create_put_bind_template_files(src_ship_dir,erb_files,params)
    end

    def create_run_files

    end
  end
end
