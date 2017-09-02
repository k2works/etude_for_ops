module EtudeForOps
  class EnvironmentVariable
    attr_accessor :tmp_file_dir

    def create_set_env_sh(config,params,config_env_dir)
      erb_file = get_set_dev_env_erb_file
      template = File.read(erb_file)
      erb = ERB.new(template, nil, '%')
      File.open("#{config_env_dir}/set-dev-env.sh", 'w') do |file|
        file.puts(erb.result(binding))
      end
    end

    private

    def get_set_dev_env_erb_file
      "#{tmp_file_dir}/set_dev_env.sh.erb"
    end
  end
end
