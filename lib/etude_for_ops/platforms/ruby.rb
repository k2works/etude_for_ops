module EtudeForOps
  class Ruby < Platform
    def create_build_files
      setup_chef_files
      setup_sh_files
    end

    def create_ship_files
      setup_capistrano_files
    end

    def create_run_files
      setup_config_files
      setup_rake_files
    end

    def get_template_params(params)
      params[:config_vm_networks] << '# config.vm.network :forwarded_port, guest:80, host:80, id:"nginx"'
      params[:config_vm_networks] << '# config.vm.network :forwarded_port, guest:3000, host:3000, id:"rails"'
      params[:config_vm_networks] << '# config.vm.network :forwarded_port, guest:8808, host:8808, id:"yard"'
      params[:config_vm_networks] << '# config.vm.network :forwarded_port, guest:3306, host:3306, id:"mysql"'
    end

    private
    def setup_chef_files
      chef = EtudeForOps::Chef.new(self)
      chef.setup_files
    end

    def setup_capistrano_files
      capistrano = EtudeForOps::Capistrano.new(self)
      capistrano.setup_files
    end

    def setup_sh_files
      shell = EtudeForOps::Shell.new(self)
      shell.setup_sh_files
    end

    def setup_rake_files
      rake = EtudeForOps::Rake.new(self)
      rake.setup_files
    end

    def setup_config_files
      config = EtudeForOps::Configure.new(self)
      config.setup_files
    end
  end
end
