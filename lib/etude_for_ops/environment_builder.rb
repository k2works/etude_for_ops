module EtudeForOps
  class EnvironmentBuilder
    def set_env(env)
      @environment = env
    end

    def create_directory
      @environment.make_root_dir
      @environment.make_env_dir
      @environment.make_env_config_dir
      @environment.make_env_config_env_dir
      @environment.make_env_config_secure_dir
      @environment.make_env_src_dir
      @environment.make_env_src_build_dir
      @environment.make_env_src_ship_dir
      @environment.make_env_src_run_dir
    end

    def environment
      @environment
    end
  end
end
