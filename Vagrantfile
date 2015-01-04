VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu-server-12042-x64-vbox4210"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"

  config.vm.network :forwarded_port, guest: 3000, host: 4000

  config.vm.provider :virtualbox do |vb|
    vb.name = "dashtag"
  end

  config.librarian_puppet.puppetfile_dir = "puppet"
  config.librarian_puppet.placeholder_filename = ".gitkeep"

  config.vm.provision :shell, :path => "puppet/bootstrap.sh"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "init.pp"
    puppet.module_path    = "puppet/modules"
    puppet.options        = "--fileserverconfig=/vagrant/puppet/fileserver.conf"
  end

end
