module EtudeForOps
  class Staging < Environment
    def initialize(root_dir)
      @env = name
      @env_dir_name = "02_#{@env}"
      super
    end

    def tmp_file_dir
      "#{template_root_path}/02_staging"
    end

    def get_template_params(config)
      params = {}
      params[:env] = 'Staging'
      params[:env_name] = 'ステージング環境'
      params[:config_vm_box] = 'etude_for_ops/amazonlinux2'
      params[:config_vm_version] = '>=0'
      params[:config_vm_networks] = []
      params[:config_private_network_ip] = config['ops']['staging']['ip_address']
      params[:config_vb_name] = "Stg#{config['ops']['share']['application']['name']}"
      params[:application_name] = "#{config['ops']['share']['application']['name']}Staging"
      params[:application_name_short] = params[:application_name].downcase
      @platform.get_template_params(params,config)
      params
    end
  end
end
