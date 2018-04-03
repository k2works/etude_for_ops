module EtudeForOps
  class Vagrant < Ruby
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

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/platform/ruby/vagrant/#{file}.erb"
    end

    def create_build_files
      erb_files = %w[
       meta-data
       user-data
       vagrant.pem
       metadata.json
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
  end
end
