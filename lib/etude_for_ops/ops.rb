module EtudeForOps
  class Ops
    TEMPLATE_ROOT_PAHT = "#{File.dirname(__FILE__)}/templates"

    def initialize
      @builder = EnvironmentBuilder.new
    end

    def create_onpremis_ruby_development_env(root_dir)
      env = Development.new(root_dir)
      @builder.strategy = Onpremis.new(env)
      ruby = Ruby.new(env)
      @builder.platform = ruby
      @builder.platform.components << EtudeForOps::Shell.new(ruby)
      @builder.platform.components << EtudeForOps::Chef.new(ruby)
      @builder.platform.components << EtudeForOps::Capistrano.new(ruby)
      @builder.platform.components << EtudeForOps::Rake.new(ruby)
      @builder.platform.components << EtudeForOps::Configure.new(ruby)
      @builder.platform.components << EtudeForOps::Vagrant.new(ruby)
      @builder.environment = env
      @builder.apply_strategy
      return @builder.environment, @builder.platform, @builder.strategy
    end

    def create_onpremis_ruby_staging_env(root_dir)
      env = Staging.new(root_dir)
      @builder.strategy = Onpremis.new(env)
      ruby = Ruby.new(env)
      @builder.platform = ruby
      @builder.platform.components << EtudeForOps::Shell.new(ruby)
      @builder.platform.components << EtudeForOps::Chef.new(ruby)
      @builder.platform.components << EtudeForOps::Capistrano.new(ruby)
      @builder.platform.components << EtudeForOps::Rake.new(ruby)
      @builder.platform.components << EtudeForOps::Configure.new(ruby)
      @builder.platform.components << EtudeForOps::Vagrant.new(ruby)
      @builder.environment = env
      @builder.apply_strategy
      return @builder.environment, @builder.platform, @builder.strategy
    end

    def create_onpremis_ruby_production_env(root_dir)
      env = Production.new(root_dir)
      @builder.strategy = Onpremis.new(env)
      ruby = Ruby.new(env)
      @builder.platform = ruby
      @builder.platform.components << EtudeForOps::Shell.new(ruby)
      @builder.platform.components << EtudeForOps::Chef.new(ruby)
      @builder.platform.components << EtudeForOps::Capistrano.new(ruby)
      @builder.platform.components << EtudeForOps::Rake.new(ruby)
      @builder.platform.components << EtudeForOps::Configure.new(ruby)
      @builder.platform.components << EtudeForOps::Vagrant.new(ruby)
      @builder.environment = env
      @builder.apply_strategy
      return @builder.environment, @builder.platform, @builder.strategy
    end

    def create_onpremis_ruby_share_env(root_dir)
      env = Share.new(root_dir)
      @builder.strategy = Onpremis.new(env)
      ruby = Ruby.new(env)
      @builder.platform = ruby
      @builder.platform.components << EtudeForOps::Shell.new(ruby)
      @builder.platform.components << EtudeForOps::Chef.new(ruby)
      @builder.platform.components << EtudeForOps::Capistrano.new(ruby)
      @builder.platform.components << EtudeForOps::Rake.new(ruby)
      @builder.platform.components << EtudeForOps::Configure.new(ruby)
      @builder.platform.components << EtudeForOps::Vagrant.new(ruby)
      @builder.environment = env
      @builder.apply_strategy
      return @builder.environment, @builder.platform, @builder.strategy
    end

    def create_aws_ruby_development_env(root_dir)
    end

    def create_aws_ruby_staging_env(root_dir)
    end

    def create_aws_ruby_production_env(root_dir)
    end

    def create_aws_ruby_share_env(root_dir)
    end
  end
end
