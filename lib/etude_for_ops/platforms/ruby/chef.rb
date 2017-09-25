module EtudeForOps
  class Chef < Ruby
    def initialize(platform)
      @platform = platform
    end

    def build
      create_dir
      create_files
      create_erb_template_files
    end

    def ship

    end

    def run

    end

    private

    def create_dir
      FileUtils.mkdir_p(chef_src_build_dir, mode: 0o755)
    end

    def chef_src_build_dir
      "#{@platform.src_build_dir}/chef"
    end

    def chef_erb_file(file)
      "#{@platform.tmp_file_dir}/platform/ruby/chef/#{file}.erb"
    end

    def chef_erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/platform/ruby/chef/#{file}.erb"
    end

    def create_files
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
        recipes_setup_nginx.rb
        recipes_setup_service.rb
        recipes.setup_td-agent.rb
        recipes.setup_elasticsearch.rb
      ]

      platform_ruby_chef_files.each do |platform_file|
        erb_file = chef_erb_file(platform_file)

        if File.exist?(erb_file)
          put_bind_template_file(chef_src_build_dir,erb_file,platform_file)
        else
          erb_file = chef_erb_share_file(platform_file)
          put_bind_template_file(chef_src_build_dir,erb_file,platform_file)
        end
      end
    end

    def create_erb_template_files
      erb_template_files = %w[
        templates_default_banner
        templates_default_bash_profile
        templates_default_grants.sql
        templates_default_my_extra_settings
        templates_default_nginx.default.conf
        templates_default_nginx.proxy.conf
        templates_default_puma
        templates_default_puma.service
        templates_default_active_job
        templates_default_active_job.service
        templates_default_td-agent.conf
      ]

      erb_template_files.each do |erb_template|
        file_cp = lambda do |erb_file|
          FileUtils.cp(erb_file, "#{chef_src_build_dir}/#{erb_template}.erb")
        end

        erb_file = chef_erb_file(erb_template)
        if File.exist?(erb_file)
          copy_template_file(chef_src_build_dir,erb_file,erb_template)
        else
          erb_file = chef_erb_share_file(erb_template)
          copy_template_file(chef_src_build_dir,erb_file,erb_template)
        end
      end
    end
  end
end
