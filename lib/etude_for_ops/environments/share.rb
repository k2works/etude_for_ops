module EtudeForOps
  class Share < Environment
    def initialize(root_dir)
      @env = name
      @env_dir_name = "99_#{@env}"
      super
    end

    def tmp_file_dir
      "#{template_root_path}/99_share"
    end

    def get_template_params(config)
      params = {}
      params[:env_name] = '共通環境'
      params[:config_vm_box] = 'amazonlinux2'
      params[:config_vm_version] = '>=0'
      params[:config_vm_networks] = [
          '# config.vm.network :forwarded_port, guest:80, host:8080, id:"HTTP"',
          '# config.vm.network :forwarded_port, guest:3306, host:3306, id:"mysql"',
          '# config.vm.network :forwarded_port, guest:5432, host:5432, id:"postgresql"'
      ]
      params[:config_private_network_ip] = '192.168.33.1'
      params[:config_vb_name] = "Base#{config['ops']['share']['application']['name']}"
      @platform.get_template_params(params,config)
      params
    end
  end
end
