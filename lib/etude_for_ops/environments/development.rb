module EtudeForOps
  class Development < Environment
    def initialize(root_dir)
      @env = name
      @env_dir_name = "01_#{@env}"
      super
    end

    def get_readme_erb_file
      'lib/etude_for_ops/templates/README.md.erb'
    end

    def get_set_dev_env_erb_file
      'lib/etude_for_ops/templates/development/onpremis/set_dev_env.sh.erb'
    end

    def get_template_params
      params = {}
      params[:env_name] = '開発環境'
      params
    end
  end
end
