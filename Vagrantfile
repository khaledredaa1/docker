Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  
  # Enable SSH agent forwarding globally
  config.ssh.forward_agent = true

    ### Prom & Grafana vm ###
    config.vm.define "docker01" do |docker01|
      docker01.vm.box = "ubuntu/jammy64"
      docker01.vm.hostname = "docker01"
      docker01.vm.network "private_network", ip: "192.168.56.100"
      docker01.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
      end
    end
end
