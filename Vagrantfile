# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

CLOUD_CONFIG_PATH = File.join(File.dirname(__FILE__), 'cloud-config.yml')
NUMBER_INSTANCES = ENV['NUMBER_INSTANCES'].to_i || 1
PUBLIC_SSH_PORT  = ENV['PUBLIC_SSH_PORT'] || 22

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # always use Vagrants insecure key
  config.ssh.insert_key = false

  # For Development settings
  config.vm.provider :virtualbox do |provider, override|
    override.vm.box     = 'coreos-stable'
    override.vm.box_url = 'http://stable.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json'

    if File.exists?(CLOUD_CONFIG_PATH)
      override.vm.provision :file, source: "#{CLOUD_CONFIG_PATH}", destination: '/tmp/vagrantfile-user-data'
      override.vm.provision :shell, inline: 'mv /tmp/vagrantfile-user-data /var/lib/coreos-vagrant'
    end

    override.ssh.guest_port = PUBLIC_SSH_PORT
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

  # For Production settings
  config.vm.provider :digital_ocean do |provider, override|
    override.vm.box               = 'digital_ocean'
    override.vm.box_url           = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    provider.token                = ENV['DIGITAL_OCEAN_TOKEN']
    provider.image                = 'coreos-stable'
    provider.region               = 'sgp1'
    provider.size                 = '512mb'
    provider.setup                = false
    provider.private_networking   = true
    provider.ssh_key_name         = ENV['DIGITAL_OCEAN_SSH_KEY_NAME']
    provider.user_data            = File.read('cloud-config.yml')
  end

  # Setup CoreOS clusters
  (1..NUMBER_INSTANCES).each do |i|
    vm_name = 'core-%02d' % i

    config.vm.define vm_name do |cluster|
      cluster.vm.hostname = vm_name

      cluster.vm.provider :virtualbox do |_, override|
        override.vm.network :private_network, ip: "172.17.8.#{i + 100}"
        override.vm.network :forwarded_port, guest: PUBLIC_SSH_PORT, host: 2200 + i, id: 'ssh'
      end
    end
  end
end
