module EtudeForOps
  class EnvironmentBuilder
    attr_accessor :environment,
                  :platform,
                  :strategy

    def apply_strategy
      @environment.make_dir
      @environment.platform = @platform
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
