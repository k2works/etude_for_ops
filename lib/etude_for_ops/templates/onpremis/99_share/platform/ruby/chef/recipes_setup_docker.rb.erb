docker_service 'default' do
  if node['etc']['passwd']['vagrant']
    action [:create, :start]
  else
    action [:create]
  end
end

include_recipe 'docker_compose::installation'

bash "install docker-machine" do
  code <<-EOC
    curl -L https://github.com/docker/machine/releases/download/v#{node['docker-machine']['version']}/docker-machine-`uname -s`-`uname -m` > /usr/local/docker-machine-#{node['docker-machine']['version']} && \
    ln -s /usr/local/docker-machine-#{node['docker-machine']['version']} /usr/local/bin/docker-machine && \
    chmod +x /usr/local/bin/docker-machine
  EOC
  not_if {File.exists?("/usr/local/docker-machine-#{node['docker-machine']['version']}")}
end

members = []
if node['etc']['passwd']['vagrant']
  members << 'vagrant'
end
if node['etc']['passwd']['ubuntu']
  members << 'ubuntu'
end
if node['etc']['passwd']['kitchen']
  members << 'kitchen'
end

unless members.empty?
  group 'docker' do
    action [:modify]
    members members
    append true
  end
end
