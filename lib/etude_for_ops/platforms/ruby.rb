module EtudeForOps
  class Ruby < Platform
    def get_template_params(params,config)
      params[:config_vm_networks] << '# config.vm.network :forwarded_port, guest:80, host:80, id:"nginx"'
      params[:config_vm_networks] << '# config.vm.network :forwarded_port, guest:3000, host:3000, id:"rails"'
      params[:config_vm_networks] << '# config.vm.network :forwarded_port, guest:8808, host:8808, id:"yard"'
      params[:config_vm_networks] << '# config.vm.network :forwarded_port, guest:3306, host:3306, id:"mysql"'
    end
  end
end
