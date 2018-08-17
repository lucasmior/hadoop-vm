# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Proxy configuration:
  #
  if ENV['http_proxy'] || ENV['https_proxy']
    if Vagrant.has_plugin?('vagrant-proxyconf')
      config.proxy.http     = ENV['http_proxy']
      config.proxy.https    = ENV['https_proxy']
      config.proxy.no_proxy = 'localhost,127.0.0.1'
      config.proxy.enabled  = { npm: false }
    else
      puts '.'
      puts 'ERROR: Could not find vagrant-proxyconf plugin.'
      puts 'INFO: $ vagrant plugin install vagrant-proxyconf'
      puts 'ERROR: Bailing out.'
      puts '.'
      exit 1
    end
  end

  # VB Guest Additions configuration:
  #
  if Vagrant.has_plugin?('vagrant-vbguest')
    config.vbguest.auto_reboot = true
  else
    puts '.'
    puts 'WARN: Could not find vagrant-vbguest plugin.'
    puts 'INFO: This plugin is highly recommended as it ensures that your VB guest additions are up-to-date.'
    puts 'INFO: $ vagrant plugin install vagrant-vbguest'
    puts '.'
  end
  
  config.vm.box = "ubuntu/xenial64"

  # Forward ports
  # HDFS Namenode Web UI
  config.vm.network "forwarded_port", guest: 50070, host: 50070, host_ip: "127.0.0.1", auto_correct: true
  # YARN Resource Manager Web UI
  config.vm.network "forwarded_port", guest: 8088, host: 8088, host_ip: "127.0.0.1", auto_correct: true

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = 4096
  end

  # config.vm.synced_folder "./", "/vagrant",
  #   :owner => "vagrant",
  #   :group => "vagrant",
  #   mount_options: ["dmode=700,fmode=700"]

  config.vm.provision "shell", privileged:true, path: "setupadmin.sh"
  config.vm.provision "shell", privileged:false, path: "setuphadoop.sh"
  config.vm.provision "shell", privileged:false, path: "startdaemons.sh", run: "always"
  config.vm.provision "shell", privileged:false, path: "confighdfsdirs.sh"
end
