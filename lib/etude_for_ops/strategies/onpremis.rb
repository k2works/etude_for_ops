module EtudeForOps
  class Onpremis < Strategy
    def apply_env
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

    def create_readme_file
      config = YAML.load_file(get_ops_yml)
      params = @environment.get_template_params(config)
      erb_file = @environment.get_readme_erb_file
      template = File.read(erb_file)
      erb = ERB.new(template, nil, "%")
      File.open("#{@environment.env_dir}/README.md", 'w') do |file|
        file.puts(erb.result(binding))
      end
    end

    def create_vagrant_file
      config = YAML.load_file(get_ops_yml)
      params = @environment.get_template_params(config)
      erb_file = @environment.get_vagrant_erb_file
      template = File.read(erb_file)
      erb = ERB.new(template, nil, "%")
      File.open("#{@environment.env_dir}/Vagrantfile", 'w') do |file|
        file.puts(erb.result(binding))
      end
    end

    def create_set_env_sh
      config = YAML.load_file(get_ops_yml)
      params = @environment.get_template_params(config)
      erb_file = @environment.get_set_dev_env_erb_file
      template = File.read(erb_file)
      erb = ERB.new(template, nil, "%")
      File.open("#{@environment.config_env_dir}/set-dev-env.sh", 'w') do |file|
        file.puts(erb.result(binding))
      end
    end

    def create_platform_files
      config = YAML.load_file(get_ops_yml)
      params = @environment.get_template_params(config)
      platform_ruby_chef_files = %w[attributes_default.rb
                                    metadata.rb
                                    chef.json
                                    recipes_default.rb
                                    ]
      src_build_dir = "#{@environment.src_build_dir}/chef"
      FileUtils.mkdir_p(src_build_dir, mode:0755)
      platform_ruby_chef_files.each do |platform_file|
        erb_file = @environment.get_platform_ruby_chef_erb_file(platform_file)
        template = File.read(erb_file)
        erb = ERB.new(template, nil, "%")
        File.open("#{src_build_dir}/#{platform_file}", 'w') do |file|
          file.puts(erb.result(binding))
        end
      end

      platform_ruby_chef_erb_template_files = %w[
          templates_default_banner
          templates_default_bash_profile
          templates_default_grants.sql
          templates_default_my_extra_settings
      ]
      platform_ruby_chef_erb_template_files.each do |erb_template|
        erb_file = @environment.get_platform_ruby_chef_erb_file(erb_template)
        FileUtils.cp(erb_file,"#{src_build_dir}/#{erb_template}.erb")
      end
    end
  end
end
