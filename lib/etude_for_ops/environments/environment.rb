module EtudeForOps
  class Environment
    def initialize(root_dir='ops')
      @root_dir = root_dir
      @env_dir = "#{@root_dir}/#{@env_dir_name}"
      @config_dir = "#{@env_dir}/config"
      @config_env_dir = "#{@config_dir}/env"
      @config_secure_dir = "#{@config_dir}/secure"
      @src_dir = "#{@env_dir}/src"
      @src_build_dir = "#{@src_dir}/build"
      @src_ship_dir = "#{@src_dir}/ship"
      @src_run_dir = "#{@src_dir}/run"
    end

    def name
      self.fullname.split('::').last.downcase
    end

    def fullname
      self.class.to_s
    end

    def make_root_dir
      FileUtils.mkdir_p(@root_dir, mode:0755)
    end

    def make_env_dir
      FileUtils.mkdir_p(@env_dir, mode:0755)
    end

    def make_env_config_dir
      FileUtils.mkdir_p(@config_dir, mode:0755)
    end

    def make_env_config_env_dir
      FileUtils.mkdir_p(@config_env_dir, mode:0755)
    end

    def make_env_config_secure_dir
      FileUtils.mkdir_p(@config_secure_dir, mode:0755)
    end

    def make_env_src_dir
      FileUtils.mkdir_p(@src_dir, mode:0755)
    end

    def make_env_src_build_dir
      FileUtils.mkdir_p(@src_build_dir, mode:0755)
    end

    def make_env_src_ship_dir
      FileUtils.mkdir_p(@src_ship_dir, mode:0755)
    end

    def make_env_src_run_dir
      FileUtils.mkdir_p(@src_run_dir, mode:0755)
    end
  end
end
