module EtudeForOps
  class Ops
    TEMPLATE_ROOT_PAHT = "#{File.dirname(__FILE__)}/templates"
    COMMON_TEMPLATE_ROOT_PAHT = "#{File.dirname(__FILE__)}/templates/common"

    def initialize
      @builder = EnvironmentBuilder.new
    end

    def create_onpremis_ruby_development_env(root_dir)
      begin
        env = Development.new(root_dir)
        @builder.strategy = Onpremis.new(env)

        ruby = Ruby.new(env)
        ruby.components << EtudeForOps::Shell.new(ruby)
        ruby.components << EtudeForOps::Chef.new(ruby)
        ruby.components << EtudeForOps::Capistrano.new(ruby)
        ruby.components << EtudeForOps::Rake.new(ruby)
        ruby.components << EtudeForOps::Configure.new(ruby)
        ruby.components << EtudeForOps::Vagrant.new(ruby)
        @builder.platforms <<  ruby

        @builder.environment = env
        @builder.apply_strategy
        return @builder.environment, @builder.platforms, @builder.strategy
      rescue Exception => e
        puts "Error occurred (#{e.class})"
        throw e
      end
    end

    def create_onpremis_ruby_staging_env(root_dir)
      begin
        env = Staging.new(root_dir)
        @builder.strategy = Onpremis.new(env)

        ruby = Ruby.new(env)
        ruby.components << EtudeForOps::Shell.new(ruby)
        ruby.components << EtudeForOps::Chef.new(ruby)
        ruby.components << EtudeForOps::Capistrano.new(ruby)
        ruby.components << EtudeForOps::Rake.new(ruby)
        ruby.components << EtudeForOps::Configure.new(ruby)
        ruby.components << EtudeForOps::Vagrant.new(ruby)
        @builder.platforms <<  ruby

        @builder.environment = env
        @builder.apply_strategy
        return @builder.environment, @builder.platforms, @builder.strategy
      rescue Exception => e
        puts "Error occurred (#{e.class})"
        throw e
      end
    end

    def create_onpremis_ruby_production_env(root_dir)
      begin
        env = Production.new(root_dir)
        @builder.strategy = Onpremis.new(env)

        ruby = Ruby.new(env)
        ruby.components << EtudeForOps::Shell.new(ruby)
        ruby.components << EtudeForOps::Chef.new(ruby)
        ruby.components << EtudeForOps::Capistrano.new(ruby)
        ruby.components << EtudeForOps::Rake.new(ruby)
        ruby.components << EtudeForOps::Configure.new(ruby)
        ruby.components << EtudeForOps::Vagrant.new(ruby)
        @builder.platforms <<  ruby

        @builder.environment = env
        @builder.apply_strategy
        return @builder.environment, @builder.platforms, @builder.strategy
      rescue Exception => e
        puts "Error occurred (#{e.class})"
        throw e
      end
    end

    def create_onpremis_ruby_share_env(root_dir)
      begin
        env = Share.new(root_dir)
        @builder.strategy = Onpremis.new(env)

        ruby = Ruby.new(env)
        ruby.components << EtudeForOps::Shell.new(ruby)
        ruby.components << EtudeForOps::Chef.new(ruby)
        ruby.components << EtudeForOps::Capistrano.new(ruby)
        ruby.components << EtudeForOps::Rake.new(ruby)
        ruby.components << EtudeForOps::Configure.new(ruby)
        ruby.components << EtudeForOps::Vagrant.new(ruby)
        @builder.platforms <<  ruby

        @builder.environment = env
        @builder.apply_strategy
        return @builder.environment, @builder.platforms, @builder.strategy
      rescue Exception => e
        puts "Error occurred (#{e.class})"
        throw e
      end
    end

    def create_aws_ruby_development_env(root_dir)
      begin
        env = Development.new(root_dir)
        aws = EtudeForOps::AWS.new(env)

        @builder.strategy = Cloud.new(aws,env)
        aws.components << EtudeForOps::EC2.new(aws)
        aws.components << EtudeForOps::VPC.new(aws)
        aws.components << EtudeForOps::RDS.new(aws)
        @builder.platforms << aws

        ruby = Ruby.new(env)
        ruby.components << EtudeForOps::Shell.new(ruby)
        ruby.components << EtudeForOps::Chef.new(ruby)
        ruby.components << EtudeForOps::Capistrano.new(ruby)
        ruby.components << EtudeForOps::Rake.new(ruby)
        ruby.components << EtudeForOps::Configure.new(ruby)
        ruby.components << EtudeForOps::Vagrant.new(ruby)
        @builder.platforms <<  ruby

        @builder.environment = env
        @builder.apply_strategy
        return @builder.environment, @builder.platforms, @builder.strategy
      rescue Exception => e
        puts "Error occurred (#{e.class})"
        throw e
      end
    end

    def create_aws_ruby_staging_env(root_dir)
      begin
        env = Staging.new(root_dir)
        aws = EtudeForOps::AWS.new(env)

        @builder.strategy = Cloud.new(aws,env)
        aws.components << EtudeForOps::EC2.new(aws)
        aws.components << EtudeForOps::VPC.new(aws)
        aws.components << EtudeForOps::RDS.new(aws)
        aws.components << EtudeForOps::EB.new(aws)
        @builder.platforms << aws

        ruby = Ruby.new(env)
        ruby.components << EtudeForOps::Shell.new(ruby)
        ruby.components << EtudeForOps::Chef.new(ruby)
        ruby.components << EtudeForOps::Capistrano.new(ruby)
        ruby.components << EtudeForOps::Rake.new(ruby)
        ruby.components << EtudeForOps::Configure.new(ruby)
        ruby.components << EtudeForOps::Vagrant.new(ruby)
        @builder.platforms <<  ruby

        @builder.environment = env
        @builder.apply_strategy
        return @builder.environment, @builder.platforms, @builder.strategy
      rescue Exception => e
        puts "Error occurred (#{e.class})"
        throw e
      end
    end

    def create_aws_ruby_production_env(root_dir)
    end

    def create_aws_ruby_share_env(root_dir)
    end
  end
end
