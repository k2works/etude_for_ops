module EtudeForOps
  class Strategy
    attr_accessor :environment

    def apply_env
    end

    def apply_env_config
    end

    def apply_env_src
    end

    protected
    def get_ops_yml
      "#{@environment.root_dir}/ops.yml"
    end
  end
end
