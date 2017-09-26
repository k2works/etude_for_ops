module EtudeForOps
  class Shell < Ruby
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
      "#{@platform.src_build_dir}/sh"
    end

    def src_ship_dir
      "#{@platform.src_ship_dir}/sh"
    end

    def src_run_dir
      "#{@platform.src_run_dir}/sh"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/ruby/sh/#{file}.erb"
    end

    def create_build_files
      FileUtils.mkdir_p(src_build_dir, mode: 0o755)

      erb_sh_files = %w[
        build.sh
      ]

      create_put_bind_template_files(src_build_dir,erb_sh_files)
    end

    def create_ship_files
      FileUtils.mkdir_p(src_ship_dir, mode: 0o755)

      erb_sh_files = %w[
        ship.sh
      ]

      create_put_bind_template_files(src_ship_dir,erb_sh_files)
    end

    def create_run_files
      FileUtils.mkdir_p(src_run_dir, mode: 0o755)

      erb_sh_files = %w[
        run.sh
      ]

      create_put_bind_template_files(src_run_dir,erb_sh_files)
    end
  end
end
