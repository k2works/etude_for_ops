module EtudeForOps
  class Share < Environment
    def initialize(root_dir)
      @env = name
      @env_dir_name = "99_#{@env}"
      super
    end

    def get_set_dev_env_template
      template = <<TEMPLATE
#!/usr/bin/env bash
export ORGANIZATION=<%= config['ops']['share']['organization'] %>
TEMPLATE
      template
    end
  end
end
