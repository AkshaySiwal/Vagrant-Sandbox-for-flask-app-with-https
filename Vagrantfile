
Vagrant.configure("2") do |config|
  config.vm.box = "centos/6"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443
  config.vm.network "forwarded_port", guest: 5000, host: 6000
  config.vm.provision "shell", path: "akshay_provisioner_script.sh"
end
