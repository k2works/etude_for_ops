module EtudeForOps
  class EnvironmentBuilder
    attr_accessor :environment,
                  :platform,
                  :strategy

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
      @environment.make_dir
      @environment.platform = @platform
      @strategy.environment = @environment
      @strategy.apply_env
      @strategy.apply_env_config
      @strategy.apply_env_src
    end

    def environment
      @environment
    end

    def platform
      @platform
    end

    def strategy
      @strategy
    end
  end
end
