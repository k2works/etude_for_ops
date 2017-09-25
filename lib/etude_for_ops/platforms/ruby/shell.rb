module EtudeForOps
  class Shell < Ruby
    def initialize(platform)
      @platform = platform
    end

    def setup_sh_files
      create_dir
      create_files
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

    def create_dir
      FileUtils.mkdir_p(sh_src_build_dir, mode: 0o755)
      FileUtils.mkdir_p(sh_src_ship_dir, mode: 0o755)
      FileUtils.mkdir_p(sh_src_run_dir, mode: 0o755)
    end

    def create_files
      file_put = lambda do |sh_dir, erb_file, sh_file|
        template = File.read(erb_file)
        erb = ERB.new(template, nil, '%')
        File.open("#{sh_dir}/#{sh_file}", 'w') do |file|
          file.puts(erb.result(binding))
        end
      end

      erb_sh_files = %w[
        build.sh
      ]
      erb_sh_files.each do |sh_file|
        erb_file = sh_erb_file(sh_file)
        file_put.call(sh_src_build_dir, erb_file, sh_file) if File.exist?(erb_file)
      end

      erb_sh_files = %w[
        ship.sh
      ]
      erb_sh_files.each do |sh_file|
        erb_file = sh_erb_file(sh_file)
        file_put.call(sh_src_ship_dir, erb_file, sh_file) if File.exist?(erb_file)
      end

      erb_sh_files = %w[
        run.sh
      ]
      erb_sh_files.each do |sh_file|
        erb_file = sh_erb_file(sh_file)
        file_put.call(sh_src_run_dir, erb_file, sh_file) if File.exist?(erb_file)
      end
    end
  end
end
