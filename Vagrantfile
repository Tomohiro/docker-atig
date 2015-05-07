# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

CLOUD_CONFIG_PATH = File.join(File.dirname(__FILE__), 'cloud-config.yml')
NUMBER_INSTANCES  = 1
FORWARDED_PORTS   = {
  16668 => 16668
}

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
  if Vagrant.has_plugin?('vagrant-vbguest')
    config.vbguest.auto_update = false
  end

  (1..NUMBER_INSTANCES).each do |i|
    vm_name = 'core-%02d' % i

    config.vm.define vm_name do |cluster|
      cluster.vm.hostname = vm_name
      cluster.vm.network :private_network, ip: "172.17.8.#{i + 100}"

      cluster.vm.network 'forwarded_port', guest: 2375, host: (2375 + i - 1), auto_correct: true

      FORWARDED_PORTS.each do |guest, host|
        cluster.vm.network 'forwarded_port', guest: guest, host: host, auto_correct: true
      end

      if File.exists?(CLOUD_CONFIG_PATH)
        cluster.vm.provision :file, source: "#{CLOUD_CONFIG_PATH}", destination: '/tmp/vagrantfile-user-data'
        cluster.vm.provision :shell, inline: 'mv /tmp/vagrantfile-user-data /var/lib/coreos-vagrant/', privileged: true
      end
    end
  end
end
