require_relative '../utiles/file_utile'

module EtudeForOps
  class Platform
    include FileUtile
    attr_accessor :params,
                  :tmp_file_dir,
                  :src_build_dir,
                  :src_ship_dir,
                  :src_run_dir,
                  :tmp_share_file_dir,
                  :components

    def initialize(env=nil)
      unless env.nil?
        @tmp_file_dir = env.tmp_file_dir
        @src_build_dir = env.src_build_dir
        @src_ship_dir = env.src_ship_dir
        @src_run_dir = env.src_run_dir
        @tmp_share_file_dir = env.tmp_share_file_dir
        @components = []
      end
    end

    def build
      @components.each do |component|
        component.build
      end
    end

    def ship
      @components.each do |component|
        component.ship
      end
    end

    def run
      @components.each do |component|
        component.run
      end
    end

    def erb_file(file)
    end

    def erb_share_file(file)
    end

    protected

    def create_put_bind_template_files(src_dir,erb_files, params={})
      FileUtils.mkdir_p(src_dir, mode: 0o755)

      erb_files.each do |file|
        erb_file = erb_file(file)
        put_bind_template_file(src_dir, erb_file, file, params) unless check_file_nil_or_not_exist(erb_file)

        erb_file = erb_share_file(file)
        put_bind_template_file(src_dir, erb_file, file, params) unless check_file_nil_or_not_exist(erb_file)
      end
    end

    def create_copy_template_files(src_dir,erb_files, params={})
      FileUtils.mkdir_p(src_dir, mode: 0o755)

      erb_files.each do |file|
        erb_file = erb_file(file)
        copy_template_file(src_dir, erb_file, file) unless check_file_nil_or_not_exist(erb_file)

        erb_file = erb_share_file(file)
        copy_template_file(src_dir, erb_file, file) unless check_file_nil_or_not_exist(erb_file)
      end
    end

    def check_file_nil_or_not_exist(file)
      if file.nil?
        true
      elsif !File.exist?(file)
        true
      else
        false
      end
    end
  end
end
