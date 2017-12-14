module EtudeForOps
  class RDS < Platform
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
      "#{@platform.src_build_dir}/aws/rds"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/aws/rds/#{file}.erb"
    end

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/platform/aws/rds/#{file}.erb"
    end

    def create_build_files
      FileUtils.mkdir_p(src_build_dir, mode: 0o755)

      erb_files = %w[
        create_stack.sh
        destroy_stack.sh
        rds-mysql.template
        rds-oracle.template
        rds-postgresql.template
        rds-parameter.json
      ]

      if @platform.params[:env] == 'Development'
        @platform.params[:rds_stackname] = 'DEV_RDS_STACKNAME'
        @platform.params[:rds_template]  = 'DEV_RDS_TEMPLATE'
        @platform.params[:rds_template_params]  = 'DEV_RDS_TEMPLATE_PARAMS'
        @platform.params[:rds_tagkey] = 'DEV_RDS_TAGKEY'
        @platform.params[:rds_tagvalue] = 'DEV_RDS_TAGVALUE'
      end

      if @platform.params[:env] == 'Staging'
        @platform.params[:rds_stackname] = 'STG_RDS_STACKNAME'
        @platform.params[:rds_template]  = 'STG_RDS_TEMPLATE'
        @platform.params[:rds_template_params]  = 'STG_RDS_TEMPLATE_PARAMS'
        @platform.params[:rds_tagkey] = 'STG_RDS_TAGKEY'
        @platform.params[:rds_tagvalue] = 'STG_RDS_TAGVALUE'
      end

      create_put_bind_template_files(src_build_dir,erb_files,@platform.params)
    end

    def create_ship_files

    end

    def create_run_files

    end
  end
end
