module EtudeForOps
  class EnvironmentBuilder
    attr_accessor :environment,
                  :platforms,
                  :strategy
    def initialize
      @environment = nil
      @strategy = nil
      @platforms = []
    end

    def apply_strategy
      @environment.make_dir
      @platforms.each do |platform|
        @environment.platform = platform
        @strategy.apply_env
        @strategy.apply_env_config
        @strategy.apply_env_src
      end
    end

    def apply_update_env_value_strategy
      @environment.make_dir
      @platforms.each do |platform|
        @environment.platform = platform
        @strategy.apply_env_config
      end
    end

    def environment
      @environment
    end

    def platforms
      @platforms
    end

    def strategy
      @strategy
    end
  end
end
