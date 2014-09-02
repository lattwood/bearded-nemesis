# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

DOMAIN = 'test'

VIRTUAL_MACHINES = {
  postgres1:
  {
    hostname:   "postgres1.#{DOMAIN}",
    ram:        '512',
    role:       'db',
    networks:
    [
      {
        ip: '172.20.0.5',
        network: 'private1'
      },
      {
        ip: '172.21.0.5',
        network: 'private2'
      }
    ]
  },
  postgres2:
  {
    hostname:   "postgres2.#{DOMAIN}",
    ram:        '512',
    role:       'db',
    networks:
    [
      {
        ip: '172.20.0.6',
        network: 'private1'
      },
      {
        ip: '172.21.0.6',
        network: 'private2'
      }
    ]
  }
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.ssh.forward_agent = true

  config.vm.provision :host_shell do |host_shell|
    host_shell.inline = './scripts/update_puppet.sh'
  end

  VIRTUAL_MACHINES.each do |name, cfg|
    config.vm.define name do |vm_config|

      # additional attributes
      environment = cfg[:environment] || 'develop'

      # configure basics
      vm_config.vm.box              = cfg[:box]         if cfg[:box]
      vm_config.vm.box_url          = cfg[:box_url]     if cfg[:box_url]
      vm_config.vm.hostname         = cfg[:hostname]    if cfg[:hostname]
      vm_config.hostmanager.aliases = cfg[:hostaliases] if cfg[:hostaliases]

      if cfg[:networks]
        cfg[:networks].each do |network|
          vm_config.vm.network(
            'private_network',
            ip: network[:ip],
            virtualbox__intnet: network[:name])
        end
      end

      if cfg[:forwards]
        cfg[:forwards].each do |guest, host|
          vm_config.vm.network :forwarded_port, guest: guest, host: host
        end
      end

      if cfg[:ram]
        vm_config.vm.provider 'virtualbox' do |vb|
          vb.memory = cfg[:ram]
        end
      end

      vm_config.vm.provision :hostmanager

      vm_config.vm.provision 'puppet' do |puppet|
        puppet.working_directory = '/vagrant/puppet' # this is for hiera
        puppet.module_path       = [
          'puppet/modules/vendor',
          'puppet/modules/dogfood'
        ]
        puppet.manifests_path    = 'puppet/manifests'
        puppet.hiera_config_path = 'puppet/manifests/hiera.yaml'

        puppet.facter = {
          'vagrant'     => '1',
          'role'        => cfg[:role],
          'environment' => environment
        }

      end

    end
  end

end