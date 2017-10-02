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
      params[:config_vm_box] = 'bento/ubuntu-16.04'
      params[:config_vm_version] = '>=0'
      params[:config_vm_networks] = []
      params[:config_private_network_ip] = '127.0.0.1'
      @platform.get_template_params(params)
      params
    end
  end
end
