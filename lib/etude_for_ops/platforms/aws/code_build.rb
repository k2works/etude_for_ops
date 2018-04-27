module EtudeForOps
  class CodeBuild < Platform
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
      "#{@platform.src_ship_dir}/aws/code_build"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/aws/code_build/#{file}.erb"
    end

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/99_share/platform/aws/code_build/#{file}.erb"
    end

    def create_build_files

    end

    def create_ship_files
      FileUtils.mkdir_p(src_ship_dir, mode: 0o755)

      erb_files = %w[
        create-project.json
        create-role.json
        put-role-policy.json
        buildspec.yml
      ]

      params = {}
      if @platform.params[:env] == 'Development'
        params[:project_name] = @platform.params[:code_build_project_name]
        params[:source_type] = @platform.params[:code_build_source_type]
        params[:source_location] = @platform.params[:code_build_source_location]
        params[:region_id] = @platform.params[:code_build_region_id]
        params[:account_id] = @platform.params[:code_build_account_id]
        params[:bucket_file_name] = @platform.params[:code_build_bucket_file_name]
        params[:amazon_ecr_repo_name] = @platform.params[:amazon_ecr_repo_name]
        params[:role_name] = @platform.params[:role_name]
      end

      if @platform.params[:env] == 'Staging'
        params[:project_name] = @platform.params[:code_build_project_name]
        params[:region_id] = @platform.params[:code_build_region_id]
        params[:account_id] = @platform.params[:code_build_account_id]
        params[:bucket_file_name] = @platform.params[:code_build_bucket_file_name]
        params[:amazon_ecr_repo_name] = @platform.params[:amazon_ecr_repo_name]
        params[:role_name] = @platform.params[:role_name]
      end

      if @platform.params[:env] == 'Production'
        params[:project_name] = @platform.params[:code_build_project_name]
        params[:region_id] = @platform.params[:code_build_region_id]
        params[:account_id] = @platform.params[:code_build_account_id]
        params[:bucket_file_name] = @platform.params[:code_build_bucket_file_name]
        params[:amazon_ecr_repo_name] = @platform.params[:amazon_ecr_repo_name]
        params[:role_name] = @platform.params[:role_name]
      end

      create_put_bind_template_files(src_ship_dir,erb_files,params)
    end

    def create_run_files

    end
  end
end
