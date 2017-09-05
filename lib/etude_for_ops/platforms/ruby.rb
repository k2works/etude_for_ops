module EtudeForOps
  class Ruby < Platform
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
        provision.json
        recipes_default.rb
        recipes_setup.rb
        recipes_configure.rb
        recipes_setup_ruby.rb
        recipes_setup_mysql.rb
        recipes_setup_postgres.rb
        recipes_setup_redis.rb
        recipes_setup_mongodb.rb
        recipes_setup_node.rb
      ]

      platform_ruby_chef_files.each do |platform_file|
        file_put = ->(erb_file) do
          template = File.read(erb_file)
          erb = ERB.new(template, nil, '%')
          File.open("#{chef_src_build_dir}/#{platform_file}", 'w') do |file|
            file.puts(erb.result(binding))
          end
        end

        erb_file = chef_erb_file(platform_file)
        file_put.call(erb_file) if File.exists?(erb_file)
        erb_file = chef_erb_share_file(platform_file)
        file_put.call(erb_file) if File.exists?(erb_file)
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
        file_cp = ->(erb_file) do
          FileUtils.cp(erb_file, "#{chef_src_build_dir}/#{erb_template}.erb")
        end

        erb_file = chef_erb_file(erb_template)
        file_cp.call(erb_file) if File.exists?(erb_file)
        erb_file = chef_erb_share_file(erb_template)
        file_cp.call(erb_file) if File.exists?(erb_file)
      end
    end

    def chef_src_build_dir
      "#{@src_build_dir}/chef"
    end

    def chef_erb_file(file)
      "#{@tmp_file_dir}/platform/ruby/chef/#{file}.erb"
    end

    def chef_erb_share_file(file)
      "#{@tmp_share_file_dir}/platform/ruby/chef/#{file}.erb"
    end
  end
end
