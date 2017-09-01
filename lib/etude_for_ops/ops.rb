module EtudeForOps
  class Ops
    def initialize
      @builder = EnvironmentBuilder.new
    end

    def create_onpremis_development_env(root_dir)
      @builder.set_env(Development.new(root_dir))
      @builder.create_directory
      @builder.set_strategy(Onpremis.new)
      @builder.apply_strategy
      return @builder.environment, @builder.strategy
    end

    def create_onpremis_staging_env(root_dir)
      @builder.set_env(Staging.new(root_dir))
      @builder.create_directory
      @builder.environment
    end

    def create_onpremis_production_env(root_dir)
      @builder.set_env(Production.new(root_dir))
      @builder.create_directory
      @builder.environment
    end

    def create_onpremis_share_env(root_dir)
      @builder.set_env(Share.new(root_dir))
      @builder.create_directory
      @builder.environment
    end

    def create_aws_development_env(root_dir)
      @builder.set_env(Development.new(root_dir))
      @builder.create_directory
      @builder.environment
    end

    def create_aws_staging_env(root_dir)
      @builder.set_env(Staging.new(root_dir))
      @builder.create_directory
      @builder.environment
    end

    def create_aws_production_env(root_dir)
      @builder.set_env(Production.new(root_dir))
      @builder.create_directory
      @builder.environment
    end

    def create_aws_share_env(root_dir)
      @builder.set_env(Share.new(root_dir))
      @builder.create_directory
      @builder.environment
    end
  end
end
