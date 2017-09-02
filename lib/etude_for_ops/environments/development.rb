module EtudeForOps
  class Development < Environment
    def initialize(root_dir)
      @env = name
      @env_dir_name = "01_#{@env}"
      super
    end

    def tmp_file_dir
      "#{template_root_path}/development"
    end

    def get_template_params(config)
      params = {}
      params[:env_name] = '開発環境'
      params[:config_vm_box] = 'bento/ubuntu-16.04'
      params[:config_vm_version] = '>=0'
      params[:config_vm_networks] = []
      params[:config_private_network_ip] = config['ops']['development']['ip_address']
      @platform.get_template_params(params)
      params
    end

    def create_ops_yml
      template = File.read("#{template_root_path}/ops.yml.erb")
      erb = ERB.new(template, nil, '%')
      File.open(ops_yml_file_path, 'w') do |file|
        file.puts(erb.result(binding))
      end
    end

    def create_env_file
      config = YAML.load_file(ops_yml_file_path)
      template = File.read("#{template_root_path}/.env.erb")
      erb = ERB.new(template, nil, '%')
      File.open('.env', 'w') do |file|
        file.puts(erb.result(binding))
      end
    end

    def create_readme_file
      config = YAML.load_file(ops_yml_file_path)
      params = get_template_params(config)
      erb_file = get_readme_erb_file
      template = File.read(erb_file)
      erb = ERB.new(template, nil, '%')
      File.open("#{env_dir}/README.md", 'w') do |file|
        file.puts(erb.result(binding))
      end
    end

    def create_vagrant_file
      config = YAML.load_file(ops_yml_file_path)
      params = get_template_params(config)
      erb_file = get_vagrant_erb_file
      template = File.read(erb_file)
      erb = ERB.new(template, nil, '%')
      File.open("#{env_dir}/Vagrantfile", 'w') do |file|
        file.puts(erb.result(binding))
      end
    end

    def create_set_env_sh
      config = YAML.load_file(ops_yml_file_path)
      params = get_template_params(config)
      @config.config_env_dir = config_env_dir
      @config.tmp_file_dir = tmp_file_dir
      @config.create_set_env_sh(config,params)
    end

    def create_platform_files
      config = YAML.load_file(ops_yml_file_path)
      @platform.params = get_template_params(config)
      @platform.tmp_file_dir = tmp_file_dir
      @platform.src_build_dir = @src_build_dir
      @source.platform = @platform
      @source.create_platform_files
    end

    private

    def get_readme_erb_file
      "#{template_root_path}/README.md.erb"
    end

    def get_vagrant_erb_file
      "#{template_root_path}/Vagrantfile.erb"
    end

  end
end
