module EtudeForOps
  class Configure < Ruby
    def initialize(platform)
      @platform = platform
    end

    def build

    end

    def ship

    end

    def run
      create_dir
      create_files
    end

    private

    def src_run_dir
      "#{@platform.src_run_dir}/config"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/ruby/config/#{file}.erb"
    end

    def create_dir
      FileUtils.mkdir_p(src_run_dir, mode: 0o755)
    end

    def create_files
      erb_config_files = %w[
        schedule.rb
        sidekiq.rb
        sidekiq.yml
      ]

      create_put_bind_template_files(src_run_dir,erb_config_files)
    end
  end
end
