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

    def sh_src_build_dir
      "#{@platform.src_build_dir}/sh"
    end

    def sh_src_ship_dir
      "#{@platform.src_ship_dir}/sh"
    end

    def sh_src_run_dir
      "#{@platform.src_run_dir}/sh"
    end

    def sh_erb_file(file)
      "#{@platform.tmp_file_dir}/platform/ruby/sh/#{file}.erb"
    end

    def create_build_files
      FileUtils.mkdir_p(sh_src_build_dir, mode: 0o755)

      erb_sh_files = %w[
        build.sh
      ]
      erb_sh_files.each do |sh_file|
        erb_file = sh_erb_file(sh_file)
        put_bind_template_file(sh_src_build_dir, erb_file, sh_file) if File.exist?(erb_file)
      end
    end

    def create_ship_files
      FileUtils.mkdir_p(sh_src_ship_dir, mode: 0o755)

      erb_sh_files = %w[
        ship.sh
      ]
      erb_sh_files.each do |sh_file|
        erb_file = sh_erb_file(sh_file)
        put_bind_template_file(sh_src_ship_dir, erb_file, sh_file) if File.exist?(erb_file)
      end
    end

    def create_run_files
      FileUtils.mkdir_p(sh_src_run_dir, mode: 0o755)

      erb_sh_files = %w[
        run.sh
      ]
      erb_sh_files.each do |sh_file|
        erb_file = sh_erb_file(sh_file)
        put_bind_template_file(sh_src_run_dir, erb_file, sh_file) if File.exist?(erb_file)
      end
    end
  end
end
