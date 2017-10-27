module EtudeForOps
  module DirUtile
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