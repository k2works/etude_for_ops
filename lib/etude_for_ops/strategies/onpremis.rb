module EtudeForOps
  class Onpremis < Strategy
    TEMPLATE_ROOT_PAHT = "#{Ops::TEMPLATE_ROOT_PAHT}/onpremis"

    def apply_env
      @environment.template_root_path = Onpremis::TEMPLATE_ROOT_PAHT
      create_ops_yml
      create_env_file
      create_readme_file
      create_vagrant_file
    end

    def apply_env_config
      create_set_env_sh
    end

    def apply_env_src
      create_platform_files
    end

    private

    def create_ops_yml
      @environment.create_ops_yml
    end

    def create_env_file
      @environment.create_env_file
    end

    def create_readme_file
      @environment.create_readme_file
    end

    def create_vagrant_file
      @environment.create_vagrant_file
    end

    def create_set_env_sh
      @environment.create_set_env_sh
    end

    def create_platform_files
      @environment.create_platform_files
    end
  end
end
