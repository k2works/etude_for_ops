module EtudeForOps
  class AWS < Platform
    def template_root_path
      "#{Cloud::TEMPLATE_ROOT_PAHT}/aws"
    end

    def get_template_params(params)
      params[:strategy] = 'cloud_aws'
    end
  end
end
