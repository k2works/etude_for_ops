module EtudeForOps
  class Production < Environment
    def initialize(root_dir)
      @env = name
      @env_dir_name = "03_#{@env}"
      super
    end
  end
end
