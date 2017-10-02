module EtudeForOps
  module FileUtile
    def put_bind_template_file(dir, erb_file, bind_file)
      template = File.read(erb_file)
      erb = ERB.new(template, nil, '%')
      File.open("#{dir}/#{bind_file}", 'w') do |file|
        file.puts(erb.result(binding))
      end
    end

    def copy_template_file(copy_dir,erb_file,erb_template)
      FileUtils.cp(erb_file, "#{copy_dir}/#{erb_template}.erb")
    end
  end
end