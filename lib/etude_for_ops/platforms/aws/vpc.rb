module EtudeForOps
  class VPC < Platform
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
      "#{@platform.src_build_dir}/aws/vpc"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/aws/vpc/#{file}.erb"
    end

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/99_share/platform/aws/vpc/#{file}.erb"
    end

    def create_build_files
      FileUtils.mkdir_p(src_build_dir, mode: 0o755)

      erb_files = %w[
        vpc-2az-2subnet-pub-pri.yml
        vpc-2az-2subnet-pub.yml
        vpc-2az-4subnet-pub-pri.yml
        vpc-parameter.json
        create_stack.sh
        update_stack.sh
        destroy_stack.sh
      ]

      params = {}
      if @platform.params[:env] == 'Development'
        params[:vpc_stackname] = 'DEV_VPC_STACKNAME'
        params[:vpc_template]  = 'DEV_VPC_TEMPLATE'
        params[:vpc_template_params]  = 'DEV_VPC_TEMPLATE_PARAMS'
        params[:tagkey] = 'DEV_TAGKEY'
        params[:tagvalue] = 'DEV_TAGVALUE'
        params[:default_az1] = @platform.params[:default_az1]
        params[:default_az2] = @platform.params[:default_az2]
      end

      if @platform.params[:env] == 'Staging'
        params[:vpc_stackname] = 'STG_VPC_STACKNAME'
        params[:vpc_template]  = 'STG_VPC_TEMPLATE'
        params[:vpc_template_params]  = 'STG_VPC_TEMPLATE_PARAMS'
        params[:tagkey] = 'STG_TAGKEY'
        params[:tagvalue] = 'STG_TAGVALUE'
        params[:default_az1] = @platform.params[:default_az1]
        params[:default_az2] = @platform.params[:default_az2]
      end

      if @platform.params[:env] == 'Production'
        params[:vpc_stackname] = 'PRD_VPC_STACKNAME'
        params[:vpc_template]  = 'PRD_VPC_TEMPLATE'
        params[:vpc_template_params]  = 'PRD_VPC_TEMPLATE_PARAMS'
        params[:tagkey] = 'PRD_TAGKEY'
        params[:tagvalue] = 'PRD_TAGVALUE'
        params[:default_az1] = @platform.params[:default_az1]
        params[:default_az2] = @platform.params[:default_az2]
      end

      create_put_bind_template_files(src_build_dir,erb_files,params)
    end

    def create_ship_files

    end

    def create_run_files

    end
  end
end
