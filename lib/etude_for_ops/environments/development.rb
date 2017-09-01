module EtudeForOps
  class Development < Environment
    def initialize(root_dir)
      @env = name
      @env_dir_name = "01_#{@env}"
      super
    end

    def get_readme_erb_file
      'lib/etude_for_ops/templates/README.md.erb'
    end

    def get_set_dev_env_erb_file
      'lib/etude_for_ops/templates/development/onpremis/set_dev_env.sh.erb'
    end

    def get_vagrant_erb_file
      'lib/etude_for_ops/templates/Vagrantfile.erb'
    end

    def get_platform_ruby_chef_erb_file(file)
      "lib/etude_for_ops/templates/development/platform/ruby/chef/#{file}.erb"
    end

    def get_template_params(config)
      params = {}
      params[:env_name] = '開発環境'
      params[:config_vm_box] = 'bento/ubuntu-16.04'
      params[:config_vm_version] = '>=0'
      params[:config_vm_networks] = []
      params[:config_vm_networks] << 'config.vm.network :forwarded_port, guest:3000, host:3000, id:"rails"'
      params[:config_vm_networks] << 'config.vm.network :forwarded_port, guest:8808, host:8808, id:"yard"'
      params[:config_vm_networks] << 'config.vm.network :forwarded_port, guest:3306, host:3306, id:"mysql"'
      params[:config_private_network_ip] = config['ops']['development']['ip_address']
      params
    end
  end
end
