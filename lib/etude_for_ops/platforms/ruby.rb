module EtudeForOps
  class Ruby < Platform
    attr_accessor :params,
                  :tmp_file_dir,
                  :src_build_dir

    def create_files
      create_chef_dir
      create_chef_files
      create_chef_erb_template_files
    end

    def get_template_params(params)
      params[:config_vm_networks] << 'config.vm.network :forwarded_port, guest:80, host:80, id:"nginx"'
      params[:config_vm_networks] << 'config.vm.network :forwarded_port, guest:3000, host:3000, id:"rails"'
      params[:config_vm_networks] << 'config.vm.network :forwarded_port, guest:8808, host:8808, id:"yard"'
      params[:config_vm_networks] << 'config.vm.network :forwarded_port, guest:3306, host:3306, id:"mysql"'
    end

    private

    def create_chef_dir
      FileUtils.mkdir_p(chef_src_build_dir, mode: 0755)
    end

    def create_chef_files
      platform_ruby_chef_files = %w[
        attributes_default.rb
        metadata.rb
        chef.json
        recipes_default.rb
      ]

      platform_ruby_chef_files.each do |platform_file|
        erb_file = chef_erb_file(platform_file)
        if File.exists?(erb_file)
          template = File.read(erb_file)
          erb = ERB.new(template, nil, '%')
          File.open("#{chef_src_build_dir}/#{platform_file}", 'w') do |file|
            file.puts(erb.result(binding))
          end
        end
      end
    end

    def create_chef_erb_template_files
      erb_template_files = %w[
        templates_default_banner
        templates_default_bash_profile
        templates_default_grants.sql
        templates_default_my_extra_settings
      ]
      erb_template_files.each do |erb_template|
        erb_file = chef_erb_file(erb_template)
        FileUtils.cp(erb_file, "#{chef_src_build_dir}/#{erb_template}.erb") if File.exists?(erb_file)
      end
    end

    def chef_src_build_dir
      "#{@src_build_dir}/chef"
    end

    def chef_erb_file(file)
      "#{@tmp_file_dir}/platform/ruby/chef/#{file}.erb"
    end
  end
end
