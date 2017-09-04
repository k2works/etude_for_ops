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

    def ops_yml_file_path
      "#{@root_dir}/ops.yml"
    end
  end
end
