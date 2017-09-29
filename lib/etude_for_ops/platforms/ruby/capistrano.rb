module EtudeForOps
  class Capistrano < Ruby
    def initialize(platform)
      @platform = platform
    end

    def build

    end

    def ship
      create_dir
      create_files
      create_erb_template_files
    end

    def run

    end

    private

    def capistrano_dir
      "#{@platform.src_ship_dir}/capistrano"
    end

    def capistrano_puma_dir
      "#{@platform.src_ship_dir}/capistrano/puma"
    end

    def capistrano_td_agent_dir
      "#{@platform.src_ship_dir}/capistrano/td-agent"
    end

    def capistrano_tasks_dir
      "#{@platform.src_ship_dir}/capistrano/tasks"
    end

    def capistrano_erb_file(dir, file)
      "#{@platform.tmp_file_dir}/platform/ruby/capistrano/#{dir}/#{file}.erb"
    end

    def capistrano_erb_share_file(dir, file)
      "#{@platform.tmp_share_file_dir}/platform/ruby/capistrano/#{dir}/#{file}.erb"
    end


    def create_dir
      FileUtils.mkdir_p(capistrano_dir, mode: 0o755)
      FileUtils.mkdir_p(capistrano_puma_dir, mode: 0o755)
      FileUtils.mkdir_p(capistrano_td_agent_dir, mode: 0o755)
      FileUtils.mkdir_p(capistrano_tasks_dir, mode: 0o755)
    end

    def create_files
      erb_cap_puma_files = %w[
        development.rb
        Capfile
        deploy.rb
      ]

      erb_cap_puma_files.each do |cap_file|
        erb_file = capistrano_erb_file(:puma, cap_file)

        if File.exist?(erb_file)
          put_bind_template_file(capistrano_puma_dir, erb_file, cap_file)
        else
          erb_file = capistrano_erb_share_file(:puma, cap_file)
          put_bind_template_file(capistrano_puma_dir, erb_file, cap_file)
        end
      end

      erb_cap_td_agent_files = %w[
        td-agent.conf
        fluent-logger.yml
      ]

      erb_cap_td_agent_files.each do |cap_file|
        erb_file = capistrano_erb_file('td-agent', cap_file)

        if File.exist?(erb_file)
          put_bind_template_file(capistrano_td_agent_dir, erb_file, cap_file)
        else
          erb_file = capistrano_erb_share_file('td-agent', cap_file)
          put_bind_template_file(capistrano_td_agent_dir, erb_file, cap_file)
        end
      end


      erb_cap_tasks_files = %w[
        db.rake
        puma.rake
        active_job.rake
        td-agent.rake
      ]

      erb_cap_tasks_files.each do |cap_file|
        erb_file = capistrano_erb_file(:tasks, cap_file)

        if File.exist?(erb_file)
          put_bind_template_file(capistrano_tasks_dir, erb_file, cap_file)
        else
          erb_file = capistrano_erb_share_file(:tasks, cap_file)
          put_bind_template_file(capistrano_tasks_dir, erb_file, cap_file)
        end
      end
    end

    def create_erb_template_files
      erb_template_files = %w[
        maintenance.html
      ]

      erb_template_files.each do |erb_template|
        erb_file = capistrano_erb_file(:puma, erb_template)

        if File.exist?(erb_file)
          copy_template_file(capistrano_puma_dir,erb_file,erb_template)
        else
          erb_file = capistrano_erb_share_file(:puma, erb_template)
          copy_template_file(capistrano_puma_dir,erb_file,erb_template) if File.exist?(erb_file)
        end
      end
    end
  end
end
