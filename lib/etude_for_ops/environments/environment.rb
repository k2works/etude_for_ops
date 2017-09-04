require_relative '../utiles/dir_utile'

module EtudeForOps
  class Environment
    include DirUtile

    attr_accessor :platform,
                  :source,
                  :config,
                  :template_root_path

    attr_reader :root_dir,
                :env_dir,
                :config_dir,
                :config_env_dir,
                :config_secure_dir,
                :src_dir,
                :src_build_dir,
                :src_ship_dir,
                :src_run_dir

    def initialize(root_dir='ops')
      @root_dir = root_dir
      @env_dir = "#{@root_dir}/#{@env_dir_name}"
      @config_dir = "#{@env_dir}/config"
      @config_env_dir = "#{@config_dir}/env"
      @config_secure_dir = "#{@config_dir}/secure"
      @src_dir = "#{@env_dir}/src"
      @src_build_dir = "#{@src_dir}/build"
      @src_ship_dir = "#{@src_dir}/ship"
      @src_run_dir = "#{@src_dir}/run"
      @source = Source.new
      @config = Config.new
    end

    def name
      self.fullname.split('::').last.downcase
    end

    def fullname
      self.class.to_s
    end

    def make_dir
      make_root_dir
      make_env_dir
      make_env_config_dir
      make_env_config_env_dir
      make_env_config_secure_dir
      make_env_src_dir
      make_env_src_build_dir
      make_env_src_ship_dir
      make_env_src_run_dir
    end

    def create_ops_yml
      erb_file = "#{template_root_path}/ops.yml.erb"
      if File.exists?(erb_file)
        template = File.read(erb_file)
        erb = ERB.new(template, nil, '%')
        File.open(ops_yml_file_path, 'w') do |file|
          file.puts(erb.result(binding))
        end
      else
        raise "ops.yml.erb is not exist in #{template_root_path}"
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

    def render file
      file_path = "#{tmp_file_dir}/readme/#{file}"
      if File.exists?(file_path)
        content = File.read(File.expand_path(file_path))
        t = ERB.new(content)
        t.result(binding)
      end
    end

    private

    def ops_yml_file_path
      "#{@root_dir}/ops.yml"
    end

    def get_readme_erb_file
      "#{template_root_path}/README.md.erb"
    end

    def get_vagrant_erb_file
      "#{template_root_path}/Vagrantfile.erb"
    end
  end
end
