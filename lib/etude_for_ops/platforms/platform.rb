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
  end
end
