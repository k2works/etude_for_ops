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

    def src_build_dir
      "#{@platform.src_build_dir}/aws/ec2"
    end

    def erb_file(file)
      "#{@platform.tmp_file_dir}/platform/aws/ec2/#{file}.erb"
    end

    def erb_share_file(file)
      "#{@platform.tmp_share_file_dir}/99_share/platform/aws/ec2/#{file}.erb"
    end

    def create_build_files
      FileUtils.mkdir_p(src_build_dir, mode: 0o755)

      erb_files = %w[
        create_key_pare.sh
        create_security_group.sh
        create_instance.sh
        create_image.sh
        configure_security_group_rule.sh
        configure_resources.sh
        destroy_security_group.sh
        destroy_instance.sh
      ]

      params = {}
      if @platform.params[:env] == 'Development'
        params[:ssh_key_name] = 'DEV_SSH_KEY_NAME'
        params[:ssh_key] = 'DEV_SSH_KEY'

        params[:vpc_id] = 'DEV_VPC_ID'
        params[:ec2_sg_name] = 'DEV_EC2_SG_NAME'
        params[:ec2_sg_desc] = 'DEV_EC2_SG_DESC'

        params[:ec2_ami_id] = 'DEV_EC2_AMI_ID'
        params[:ec2_type] = 'DEV_EC2_TYPE'
        params[:ec2_sg_id] = 'DEV_EC2_SG_ID'
        params[:ec2_subnet] = 'DEV_EC2_SUBNET'

        params[:ec2_instance_id] = 'DEV_EC2_INSTANCE_ID'
        params[:ec2_image_name] = 'DEV_APPLICATION_NAME'
        params[:ec2_image_id] = 'DEV_EC2_AMI_ID'

        params[:tagkey] = 'DEV_TAGKEY'
        params[:tagvalue] = 'DEV_TAGVALUE'
      end

      if @platform.params[:env] == 'Staging'
        params[:ssh_key_name] = 'STG_SSH_KEY_NAME'
        params[:ssh_key] = 'STG_SSH_KEY'

        params[:vpc_id] = 'STG_VPC_ID'
        params[:ec2_sg_name] = 'STG_EC2_SG_NAME'
        params[:ec2_sg_desc] = 'STG_EC2_SG_DESC'

        params[:ec2_ami_id] = 'STG_EC2_AMI_ID'
        params[:ec2_type] = 'STG_EC2_TYPE'
        params[:ec2_sg_id] = 'STG_EC2_SG_ID'
        params[:ec2_subnet] = 'STG_EC2_SUBNET'

        params[:ec2_instance_id] = 'STG_EC2_INSTANCE_ID'
        params[:ec2_image_name] = 'STG_APPLICATION_NAME'
        params[:ec2_image_id] = 'STG_EC2_AMI_ID'

        params[:tagkey] = 'STG_TAGKEY'
        params[:tagvalue] = 'STG_TAGVALUE'
      end


      create_put_bind_template_files(src_build_dir,erb_files,params)
    end

    def create_ship_files

    end

    def create_run_files

    end
  end
end
