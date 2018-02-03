bash 'create swapfile' do
  user 'root'
  code <<-EOC
    dd if=/dev/zero of=/srv/swapfile bs=1M count=4096 &&
    chmod 600 /srv/swapfile
    mkswap /srv/swapfile
  EOC
  only_if "test ! -f /srv/swapfile -a `cat /proc/swaps | wc -l` -eq 1"
end

mount '/dev/null' do # swap file entry for fstab
  action :enable # cannot mount; only add to fstab
  device '/srv/swapfile'
  fstype 'swap'
end

bash 'activate swap' do
  code 'swapon -ae'
  only_if "test `cat /proc/swaps | wc -l` -eq 1"
end
