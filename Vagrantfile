# -*- mode: ruby -*-
# vi: set ft=ruby :

prefix              = "drupal"

boxtemplate         = "Ubuntu-12.04-bare-virtualbox"

source_prefix   = "source"
source_ip       = "172.16.0.21"
destination_prefix   = "destination"
destination_ip       = "172.16.0.22"

Vagrant.configure("2") do |config|
  config.vm.define "source" do |source|
    source.vm.box = boxtemplate
    source.vm.hostname = source_prefix
    source.vm.network :private_network, ip: source_ip
    source.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", "1024"]
      v.customize ["modifyvm", :id, "--cpus", "2"]
      v.name = source_prefix
    end
    source.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = "puppet.fccinteractive.com"
    end
  end
  config.vm.define "destination" do |destination|
    destination.vm.box = boxtemplate
    destination.vm.hostname = destination_prefix
    destination.vm.network :private_network, ip: destination_ip
    destination.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", "1024"]
      v.customize ["modifyvm", :id, "--cpus", "2"]
      v.name = destination_prefix
    end
    destination.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = "puppet.fccinteractive.com"
    end
  end


end
