module EtudeForOps
  class Docker < Ruby
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
      "#{@platform.src_build_dir}/docker"
    end

    def src_ship_dir
      "#{@platform.src_ship_dir}/docker"
    end

    def src_run_dir
      "#{@platform.src_run_dir}/docker"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/ruby/docker/#{file}.erb"
    end

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/platform/ruby/docker/#{file}.erb"
    end

    def create_build_files
      FileUtils.rm_r(src_build_dir) if File.directory?(src_build_dir)
      FileUtils.cp_r("#{@platform.tmp_share_file_dir}/platform/ruby/docker/build/", src_build_dir)
    end

    def create_ship_files
      FileUtils.rm_r(src_ship_dir) if File.directory?(src_ship_dir)
      FileUtils.cp_r("#{@platform.tmp_share_file_dir}/platform/ruby/docker/ship/", src_ship_dir)
    end

    def create_run_files
      FileUtils.rm_r(src_run_dir) if File.directory?(src_run_dir)
      FileUtils.cp_r("#{@platform.tmp_share_file_dir}/platform/ruby/docker/run/", src_run_dir)
    end
  end
end
