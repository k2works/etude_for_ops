module EtudeForOps
  class Config
    attr_accessor :environment_variable, :secure, :config_env_dir, :tmp_file_dir

    def initialize
      @environment_variable = EnvironmentVariable.new
      @secure = Secure.new
    end

    def create_set_env_sh(config,params)
      @environment_variable.tmp_file_dir = tmp_file_dir
      @environment_variable.create_set_env_sh(config,params,config_env_dir)
    end
  end
end
