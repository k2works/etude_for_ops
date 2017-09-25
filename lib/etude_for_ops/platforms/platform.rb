module EtudeForOps
  class Platform
    attr_accessor :params,
                  :tmp_file_dir,
                  :src_build_dir,
                  :src_ship_dir,
                  :src_run_dir,
                  :tmp_share_file_dir

  end

  def create_build_files
    raise 'abstract method is called'
  end

  def create_ship_files
    raise 'abstract method is called'
  end

  def create_run_files
    raise 'abstract method is called'
  end
end
