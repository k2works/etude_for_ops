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
      FileUtils.mkdir_p(src_build_dir, mode: 0o755)
    end

    def src_build_dir
      "#{@platform.src_build_dir}/chef"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/ruby/chef/#{file}.erb"
    end

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/platform/ruby/chef/#{file}.erb"
    end

    def create_files
      platform_ruby_chef_files = %w[
        attributes_default.rb
        metadata.rb
        provision.json
        ec2_provision.json
        recipes_default.rb
        recipes_ec2.rb
        recipes_setup.rb
        recipes_configure.rb
        recipes_configure_service.rb
        recipes_setup_ruby.rb
        recipes_setup_mysql.rb
        recipes_setup_postgres.rb
        recipes_setup_redis.rb
        recipes_setup_mongodb.rb
        recipes_setup_node.rb
        recipes_setup_nginx.rb
        recipes_setup_service.rb
        recipes_setup_td-agent.rb
        recipes_setup_elasticsearch.rb
        recipes_setup_docker.rb
        recipes_setup_jenkins.rb
        recipes_setup_aws.rb
        recipes_setup_vagrant.rb
        Vagrantfile
        .kitchen.yml
        Gemfile
        reprovision.sh
      ]

      params = {}
      params[:user] = 'vagrant'
      params[:group] = 'vagrant'
      params[:aws_user] = 'ec2-user'
      params[:aws_group] = 'ec2-user'

      if @platform.params[:env] = 'Development'
        params[:ssh_key] = 'DEV_SSH_KEY'
      end

      create_put_bind_template_files(src_build_dir,platform_ruby_chef_files, params)
    end

    def create_erb_template_files
      erb_template_files = %w[
        templates_default_banner
        templates_default_bash_profile
        templates_default_bash_profile_aws
        templates_default_grants.sql
        templates_default_my_extra_settings
        templates_default_nginx.conf
        templates_default_nginx.default.conf
        templates_default_nginx.proxy.conf
        templates_default_nginx.kibana.conf
        templates_default_nginx.jenkins.conf
        templates_default_nginx.td-agent-ui.conf
        templates_default_puma
        templates_default_puma.service
        templates_default_active_job
        templates_default_active_job.service
        templates_default_td-agent-ui
        templates_default_td-agent-ui.service
        templates_default_td-agent
        templates_default_kibana.yml
        templates_default_jenkins
      ]

      create_copy_template_files(src_build_dir,erb_template_files,params)
    end
  end
end