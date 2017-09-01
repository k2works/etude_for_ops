module EtudeForOps
  class EnvironmentBuilder
    def set_env(env)
      @environment = env
    end

    def set_strategy(strategy)
      @strategy = strategy
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

    def apply_strategy
      @strategy.environment = @environment
      @strategy.apply_env
      @strategy.apply_env_config
      @strategy.apply_env_src
    end

    def environment
      @environment
    end

    def strategy
      @strategy
    end
  end
end
