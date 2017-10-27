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
      params[:env_name] = 'ステージング環境'
      params[:config_vm_box] = 'bento/ubuntu-16.04'
      params[:config_vm_version] = '>=0'
      params[:config_vm_networks] = []
      params[:config_private_network_ip] = config['ops']['staging']['ip_address']
      @platform.get_template_params(params,config)
      params
    end
  end
end
