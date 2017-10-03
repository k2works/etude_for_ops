module EtudeForOps
  class EC2 < Platform
    def initialize(platform)
      @platform = platform
    end

    def build
      create_build_files
    end

    def ship
      create_ship_files
    end

    def run
      create_run_files
    end

    private

    def create_build_files

    end

    def create_ship_files

    end

    def create_run_files

    end
  end
end
