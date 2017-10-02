module EtudeForOps
  class Development < Environment
    def initialize(root_dir)
      @env = name
      @env_dir_name = "01_#{@env}"
      super
    end

    def tmp_file_dir
      "#{template_root_path}/01_development"
    end

    def get_template_params(config)
      params = {}
      params[:env_name] = '開発環境'
      params[:config_vm_box] = 'bento/ubuntu-16.04'
      params[:config_vm_version] = '>=0'
      params[:config_vm_networks] = []
      params[:config_private_network_ip] = config['ops']['development']['ip_address']
      params[:config_vb_name] = "Dev#{config['ops']['share']['application']}"
      @platform.get_template_params(params)
      params
    end
  end
end
