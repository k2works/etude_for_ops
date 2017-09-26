module EtudeForOps
  class Vagrant < Ruby
    def initialize(platform)
      @platform = platform
    end

    def build
    end

    def ship
      create_ship_files
    end

    def run
    end

    private

    def src_build_dir
      "#{@platform.src_build_dir}/vagrant"
    end

    def src_ship_dir
      "#{@platform.src_ship_dir}/vagrant"
    end

    def src_run_dir
      "#{@platform.src_run_dir}/vagrant"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/ruby/vagrant/#{file}.erb"
    end

    def create_build_files
      erb_files = %w[
      ]
      create_put_bind_template_files(src_build_dir,erb_files)
    end

    def create_ship_files
      erb_files = %w[
       create_box.sh
       metadata.json
      ]
      create_put_bind_template_files(src_ship_dir,erb_files)
    end

    def create_run_files
      erb_files = %w[
      ]
      create_put_bind_template_files(src_run_dir,erb_files)
    end

    def create_put_bind_template_files(src_dir,erb_files, params={})
      FileUtils.mkdir_p(src_dir, mode: 0o755)

      erb_files.each do |file|
        erb_file = erb_file(file)
        put_bind_template_file(src_dir, erb_file, file) if File.exist?(erb_file)
      end
    end
  end
end