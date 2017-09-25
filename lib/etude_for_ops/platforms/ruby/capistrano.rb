module EtudeForOps
  class Capistrano < Ruby
    def initialize(platform)
      @platform = platform
    end

    def setup_files
      create_dir
      create_files
      create_erb_template_files
    end

    private

    def capistrano_dir
      "#{@platform.src_ship_dir}/capistrano"
    end

    def capistrano_puma_dir
      "#{@platform.src_ship_dir}/capistrano/puma"
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
      FileUtils.mkdir_p(capistrano_tasks_dir, mode: 0o755)
    end

    def create_files
      file_put = lambda do |cap_ship_dir, erb_file, cap_file|
        template = File.read(erb_file)
        erb = ERB.new(template, nil, '%')
        File.open("#{cap_ship_dir}/#{cap_file}", 'w') do |file|
          file.puts(erb.result(binding))
        end
      end

      erb_cap_puma_files = %w[
        development.rb
        Capfile
        deploy.rb
      ]
      erb_cap_puma_files.each do |cap_file|
        erb_file = capistrano_erb_file(:puma, cap_file)
        file_put.call(capistrano_puma_dir, erb_file, cap_file) if File.exist?(erb_file)
        erb_file = capistrano_erb_share_file(:puma, cap_file)
        file_put.call(capistrano_puma_dir, erb_file, cap_file) if File.exist?(erb_file)
      end

      erb_cap_tasks_files = %w[
        db.rake
        puma.rake
        active_job.rake
      ]
      erb_cap_tasks_files.each do |cap_file|
        erb_file = capistrano_erb_file(:tasks, cap_file)
        file_put.call(capistrano_tasks_dir, erb_file, cap_file) if File.exist?(erb_file)
        erb_file = capistrano_erb_share_file(:tasks, cap_file)
        file_put.call(capistrano_tasks_dir, erb_file, cap_file) if File.exist?(erb_file)
      end
    end

    def create_erb_template_files
      erb_template_files = %w[
        maintenance.html
      ]

      erb_template_files.each do |erb_template|
        file_cp = lambda do |erb_file|
          FileUtils.cp(erb_file, "#{capistrano_puma_dir}/#{erb_template}.erb")
        end

        erb_file = capistrano_erb_file(:puma, erb_template)
        file_cp.call(erb_file) if File.exist?(erb_file)
        erb_file = capistrano_erb_share_file(:puma, erb_template)
        file_cp.call(erb_file) if File.exist?(erb_file)
      end
    end
  end
end
