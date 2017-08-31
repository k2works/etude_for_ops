module EtudeForOps
  class Development < Environment
    def initialize(root_dir)
      @env = name
      @env_dir_name = "01_#{@env}"
      super
    end
  end
end
