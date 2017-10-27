module EtudeForOps
  class OpsYmlGateway
    def initialize(root_dir='ops')
      @root_dir = root_dir
    end

    def ops_yml_file_path
      "#{@root_dir}/ops.yml"
    end

    def select_all
      YAML.load_file(ops_yml_file_path)
    end
  end
end
