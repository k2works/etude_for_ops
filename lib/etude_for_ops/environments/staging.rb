module EtudeForOps
  class Staging < Environment
    def initialize(root_dir)
      @env = name
      @env_dir_name = "02_#{@env}"
      super
    end
  end
end
