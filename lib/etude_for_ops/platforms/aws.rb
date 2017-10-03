module EtudeForOps
  class AWS < Platform
    def template_root_path
      "#{Cloud::TEMPLATE_ROOT_PAHT}/aws"
    end

    def get_template_params(params)

    end
  end
end
