module EtudeForOps
  class Ops
    def initialize
      @builder = EnvironmentBuilder.new
    end

    def create_onpremis_ruby_development_env(root_dir)
      @builder.strategy = Onpremis.new
      @builder.platform = Ruby.new
      @builder.environment = Development.new(root_dir)
      @builder.apply_strategy
      return @builder.environment, @builder.platform, @builder.strategy
    end

    def create_onpremis_ruby_staging_env(root_dir)
      @builder.strategy = Onpremis.new
      @builder.platform = Ruby.new
      @builder.environment = Staging.new(root_dir)
      @builder.apply_strategy
      return @builder.environment, @builder.platform, @builder.strategy
    end

    def create_onpremis_ruby_production_env(root_dir)
      @builder.strategy = Onpremis.new
      @builder.platform = Ruby.new
      @builder.environment = Production.new(root_dir)
      @builder.apply_strategy
      return @builder.environment, @builder.platform, @builder.strategy
    end

    def create_onpremis_ruby_share_env(root_dir)
      @builder.strategy = Onpremis.new
      @builder.platform = Ruby.new
      @builder.environment = Share.new(root_dir)
      @builder.apply_strategy
      return @builder.environment, @builder.platform, @builder.strategy
    end

    def create_aws_ruby_development_env(root_dir)
      @builder.environment = Development.new(root_dir)
      @builder.create_directory
      @builder.environment
    end

    def create_aws_ruby_staging_env(root_dir)
      @builder.environment = Staging.new(root_dir)
      @builder.create_directory
      @builder.environment
    end

    def create_aws_ruby_production_env(root_dir)
      @builder.environment = Production.new(root_dir)
      @builder.create_directory
      @builder.environment
    end

    def create_aws_ruby_share_env(root_dir)
      @builder.environment = Share.new(root_dir)
      @builder.environment
    end
  end
end
