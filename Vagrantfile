Vagrant.require_version ">= 2.2.8"
Vagrant.configure(2) do |config|
  config.vm.network "private_network", ip: "192.168.56.10"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.box = "ubuntu/focal64"
  config.vm.provision :ansible do |ansible|
    ansible.playbook = "ansible/main.yml"
    ansible.verbose = "v"
    ansible.extra_vars = {
      ansible_ssh_user: "vagrant"
    }
  end
end