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
      params[:env] = 'Development'
      params[:env_name] = '開発環境'
      params[:config_vm_box] = 'etude_for_ops/amazonlinux2'
      params[:config_vm_version] = '>=0'
      params[:config_vm_networks] = []
      params[:config_private_network_ip] = config['ops']['development']['ip_address']
      params[:config_vb_name] = "Dev#{config['ops']['share']['application']['name']}"
      params[:application_name] = "#{config['ops']['share']['application']['name']}Development"
      params[:application_name_short] = params[:application_name].downcase
      @platform.get_template_params(params,config)
      params
    end
  end
end
