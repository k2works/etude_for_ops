case node["platform"]
  when "debian", "ubuntu"
    template "puma" do
      path "/etc/systemd/system/puma.service"
      source "puma.service.erb"
      owner "root"
      group "root"
      mode 0751
    end
  when "redhat", "centos", "fedora"
    if platform_family?('rhel') && node['platform_version'].to_i == 7 then
      template "puma" do
        path "/etc/systemd/system/puma.service"
        source "puma.service.erb"
        owner "root"
        group "root"
        mode 0751
      end
    elsif platform_family?('rhel') && node['platform_version'].to_i == 6 then
      template "puma" do
        path "/etc/init.d/puma"
        source "puma.erb"
        owner "root"
        group "root"
        mode 0751
      end
    end
  when "amazon"
    template "puma" do
      path "/etc/init.d/puma"
      source "puma.erb"
      owner "root"
      group "root"
      mode 0751
    end
end

service "puma" do
  supports :status => true, :restrart => true, :reload => true
  action [ :enable, :start ]
end
