module EtudeForOps
  class IAM < Platform
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
      "#{@platform.src_build_dir}/aws/iam"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/aws/iam/#{file}.erb"
    end

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/99_share/platform/aws/iam/#{file}.erb"
    end

    def create_build_files
      FileUtils.mkdir_p(src_build_dir, mode: 0o755)

      erb_files = %w[
        iam-app.yml
        iam-parameter.json
        create_stack.sh
        update_stack.sh
        destroy_stack.sh
      ]

      params = {}
      if @platform.params[:env] == 'Development'
        params[:application_name] = @platform.params[:application_name]
        params[:iam_stackname] = 'DEV_IAM_STACKNAME'
        params[:iam_template]  = 'DEV_IAM_TEMPLATE'
        params[:iam_template_params]  = 'DEV_IAM_TEMPLATE_PARAMS'
        params[:tagkey] = 'DEV_TAGKEY'
        params[:tagvalue] = 'DEV_TAGVALUE'
        params[:iam_user_group] = @platform.params[:iam_user_group]
        params[:iam_user_name] = @platform.params[:iam_user_name]
        params[:iam_user_password] = @platform.params[:iam_user_password]
      end

      if @platform.params[:env] == 'Staging'
        params[:application_name] = @platform.params[:application_name]
        params[:iam_stackname] = 'STG_IAM_STACKNAME'
        params[:iam_template]  = 'STG_IAM_TEMPLATE'
        params[:iam_template_params]  = 'STG_IAM_TEMPLATE_PARAMS'
        params[:tagkey] = 'STG_TAGKEY'
        params[:tagvalue] = 'STG_TAGVALUE'
        params[:iam_user_group] = @platform.params[:iam_user_group]
        params[:iam_user_name] = @platform.params[:iam_user_name]
        params[:iam_user_password] = @platform.params[:iam_user_password]
      end

      create_put_bind_template_files(src_build_dir,erb_files,params)
    end

    def create_ship_files

    end

    def create_run_files

    end
  end
end
