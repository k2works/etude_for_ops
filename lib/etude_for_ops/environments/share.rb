module EtudeForOps
  class Share < Environment
    def initialize(root_dir)
      @env = name
      @env_dir_name = "99_#{@env}"
      super
    end
  end
end
