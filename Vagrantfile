# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

NUMBER_INSTANCES = 1

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # always use Vagrants insecure key
  config.ssh.insert_key = false

  config.vm.box     = 'coreos-alpha'
  config.vm.box_url = 'http://alpha.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json'

  config.vm.provider :virtualbox do |v|
    # On VirtualBox, we don't have guest additions or a functional vboxsf
    # in CoreOS, so tell Vagrant that so it can be smarter.
    v.check_guest_additions = false
    v.functional_vboxsf     = false
  end

  # plugin conflict
  if Vagrant.has_plugin?('vagrant-vbguest') then
    config.vbguest.auto_update = false
  end

  (1..NUMBER_INSTANCES).each do |i|
    vm_name = 'core-%02d' % i

    config.vm.define vm_name do |cluster|
      cluster.vm.hostname = vm_name
      cluster.vm.network :private_network, ip: "172.17.8.#{i + 100}"
    end
  end
end
