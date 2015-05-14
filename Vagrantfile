# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

CLOUD_CONFIG_PATH = File.join(File.dirname(__FILE__), 'cloud-config.yml')
NUMBER_INSTANCES  = 1

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # always use Vagrants insecure key
  config.ssh.insert_key = false

  # For Development settings
  config.vm.provider :virtualbox do |provider, override|
    override.vm.box     = 'coreos-alpha'
    override.vm.box_url = 'http://alpha.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json'

    if File.exists?(CLOUD_CONFIG_PATH)
      override.vm.provision :file, source: "#{CLOUD_CONFIG_PATH}", destination: '/tmp/vagrantfile-user-data'
      override.vm.provision :shell, inline: 'mv /tmp/vagrantfile-user-data /var/lib/coreos-vagrant'
      override.vm.provision :shell, inline: 'coreos-cloudinit --from-file=/var/lib/coreos-vagrant/vagrantfile-user-data'
    end

    override.vm.synced_folder '.', '/home/core/share', id: 'core', nfs: true, mount_options: ['nolock,vers=3,udp']

    # On VirtualBox, we don't have guest additions or a functional vboxsf
    # in CoreOS, so tell Vagrant that so it can be smarter.
    provider.check_guest_additions = false
    provider.functional_vboxsf     = false

    # VirtualBox plugin conflict
    if Vagrant.has_plugin?('vagrant-vbguest')
      override.vbguest.auto_update = false
    end
  end

  # Setup CoreOS clusters
  (1..NUMBER_INSTANCES).each do |i|
    vm_name = 'core-%02d' % i

    config.vm.define vm_name do |cluster|
      cluster.vm.hostname = vm_name

      cluster.vm.provider :virtualbox do |_, override|
        override.vm.network :private_network, ip: "172.17.8.#{i + 100}"
      end
    end
  end
end
