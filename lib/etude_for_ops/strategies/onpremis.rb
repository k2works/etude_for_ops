module EtudeForOps
  class Onpremis < Strategy
    def apply_env
      create_ops_yml
      create_env_file
      create_readme
    end

    def apply_env_config
      create_set_env_sh
    end

    def apply_env_src
    end

    private
    def create_ops_yml
      template = File.read('lib/etude_for_ops/templates/ops.yml.erb')
      erb = ERB.new(template, nil, "%")
      File.open(get_ops_yml, 'w') do |file|
        file.puts(erb.result(binding))
      end
    end

    def create_env_file
      config = YAML.load_file(get_ops_yml)
      template = File.read('lib/etude_for_ops/templates/.env.erb')
      erb = ERB.new(template, nil, "%")
      File.open('.env', 'w') do |file|
        file.puts(erb.result(binding))
      end
    end

    def create_readme
      config = YAML.load_file(get_ops_yml)
      params = @environment.get_template_params
      erb_file = @environment.get_readme_erb_file
      template = File.read(erb_file)
      erb = ERB.new(template, nil, "%")
      File.open("#{@environment.env_dir}/README.md", 'w') do |file|
        file.puts(erb.result(binding))
      end
    end

    def create_set_env_sh
      config = YAML.load_file(get_ops_yml)
      params = @environment.get_template_params
      erb_file = @environment.get_set_dev_env_erb_file
      template = File.read(erb_file)
      erb = ERB.new(template, nil, "%")
      File.open("#{@environment.config_env_dir}/set-dev-env.sh", 'w') do |file|
        file.puts(erb.result(binding))
      end
    end
  end
end
