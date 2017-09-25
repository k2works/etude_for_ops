module EtudeForOps
  class Source
    attr_accessor :build,:ship,:run,:platform

    def initialize
      @build = Build.new
      @ship = Ship.new
      @run = Run.new
    end

    def create_platform_files
      @build.create_platform_files(@platform)
      @ship.create_platform_files(@platform)
      @run.create_platform_files(@platform)
    end
  end
end
