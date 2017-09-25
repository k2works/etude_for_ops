module EtudeForOps
  class Configure < Ruby
    def initialize(platform)
      @platform = platform
    end

    def build

    end

    def ship

    end

    def run
      create_dir
      create_files
    end

    private

    def config_src_run_dir
      "#{@platform.src_run_dir}/config"
    end

    def config_erb_file(file)
      "#{@platform.tmp_file_dir}/platform/ruby/config/#{file}.erb"
    end

    def create_dir
      FileUtils.mkdir_p(config_src_run_dir, mode: 0o755)
    end

    def create_files
      file_put = lambda do |rake_dir, erb_file, rake_file|
        template = File.read(erb_file)
        erb = ERB.new(template, nil, '%')
        File.open("#{rake_dir}/#{rake_file}", 'w') do |file|
          file.puts(erb.result(binding))
        end
      end

      erb_config_files = %w[
        schedule.rb
        sidekiq.rb
        sidekiq.yml
      ]
      erb_config_files.each do |config_file|
        erb_file = config_erb_file(config_file)
        file_put.call(config_src_run_dir, erb_file, config_file) if File.exist?(erb_file)
      end
    end

  end
end
