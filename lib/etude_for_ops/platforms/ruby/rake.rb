module EtudeForOps
  class Rake < Ruby
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

    def rake_erb_file(file)
      "#{@platform.tmp_file_dir}/platform/ruby/rake/#{file}.erb"
    end

    def rake_erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/platform/ruby/rake/#{file}.erb"
    end

    def rake_src_run_dir
      "#{@platform.src_run_dir}/rake"
    end

    def create_dir
      FileUtils.mkdir_p(rake_src_run_dir, mode: 0o755)
    end

    def create_files
      erb_rake_files = %w[
        db.rake
      ]
      erb_rake_files.each do |rake_file|
        erb_file = rake_erb_file(rake_file)
        if File.exist?(erb_file)
          put_bind_template_file(rake_src_run_dir, erb_file, rake_file)
        else
          erb_file = rake_erb_share_file(rake_file)
          put_bind_template_file(rake_src_run_dir, erb_file, rake_file)
        end
      end
    end
  end
end
