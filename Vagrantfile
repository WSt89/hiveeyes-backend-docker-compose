Vagrant.configure("2") do |config|

  config.vm.define "hiveeyes-debian11" do |machine|

    machine.vm.box = "generic/debian11"
    machine.vm.hostname = "hiveeyes-debian10"

    machine.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "hiveeyes-debian11"]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    machine.vm.synced_folder ".", "/vagrant"

    config.vm.provision :docker
    #config.vm.provision :docker_compose, yml: "/vagrant/docker-compose-standard.yml", run:"always"

    config.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y mosquitto-clients curl httpie

      cd /vagrant
      docker-compose --file=docker-compose-standard.yml up --detach
    SHELL

  end

end
