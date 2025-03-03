# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "starboard/ubuntu-arm64-20.04.5"
  config.vm.box_version = "20221120.20.40.0"
  config.vm.box_download_insecure = true
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Disable the default share of the current code directory. Doing this
  # provides improved isolation between the vagrant box and your host
  # by making sure your Vagrantfile isn't accessible to the vagrant box.
  # If you use this you may want to enable additional shared subfolders as
  # shown above.
  # config.vm.synced_folder ".", "/vagrant", disabled: true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "vmware_desktop" do |v|
    v.ssh_info_public = true
    v.gui = true
    v.linked_clone = false
    v.vmx["ethernet0.virtualdev"] = "vmxnet3"
  end 
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
 
  config.vm.provision "file", source: "./monitor_logins.sh", destination: "/home/vagrant/monitor_logins.sh"
  config.vm.provision "file", source: "./monitor_disk.sh", destination: "/home/vagrant/monitor_disk.sh"
  config.vm.provision "file", source: "./monitor_services.sh", destination: "/home/vagrant/monitor_services.sh"

  # Provisioning to set up scripts and cron jobs
  config.vm.provision "shell", inline: <<-SHELL
    # Set execute permissions for all scripts
    sudo chmod +x /home/vagrant/monitor_logins.sh
    sudo chmod +x /home/vagrant/monitor_disk.sh
    sudo chmod +x /home/vagrant/monitor_services.sh

    # Ensure cron service is running
    sudo systemctl enable cron
    sudo systemctl start cron

    # Set up crontab for all scripts (append, don't overwrite)
    (crontab -l 2>/dev/null; echo "*/5 * * * * /home/vagrant/monitor_logins.sh") | crontab -
    (crontab -l 2>/dev/null; echo "*/5 * * * * /home/vagrant/monitor_disk.sh") | crontab -
    (crontab -l 2>/dev/null; echo "*/5 * * * * /home/vagrant/monitor_services.sh") | crontab -
  SHELL
  
  config.vm.provision "shell", inline: <<-SHELL
    sudo useradd -m newuser
    echo "newuser:password" | sudo chpasswd
    sudo usermod -aG sudo newuser
  SHELL
  config.ssh.insert_key = true
end
