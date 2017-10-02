module EtudeForOps
  module AWS
    class EC2 < EtudeForOps::Cloud
      def initialize
      end

      def template_root_path
        "#{Cloud::TEMPLATE_ROOT_PAHT}/aws"
      end
    end
  end
end
