module EtudeForOps
  class EC2 < Platform
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
      "#{@platform.src_build_dir}/aws/ec2"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/aws/ec2/#{file}.erb"
    end

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/platform/aws/ec2/#{file}.erb"
    end

    def create_build_files
      FileUtils.mkdir_p(src_build_dir, mode: 0o755)

      erb_files = %w[
        create_key_pare.sh
      ]

      params = {}
      if @platform.params[:env] = 'Development'
        params[:ssh_key_name] = 'DEV_SSH_KEY_NAME'
        params[:ssh_key] = 'DEV_SSH_KEY'
      end

      create_put_bind_template_files(src_build_dir,erb_files,params)
    end

    def create_ship_files

    end

    def create_run_files

    end
  end
end
