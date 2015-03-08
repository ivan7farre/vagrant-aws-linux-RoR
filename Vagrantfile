# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  # AWS provider
  
  config.vm.box = "dummy"
  config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
  
  config.vm.provider :aws do |aws, override|

    aws.region = "eu-west-1"
    aws.tags = {
      Name: 'Vagrant-AWS-Debian7'
    }
    aws.user_data = File.read("deploy/scripts/bootstrap.sh")

   # Add your own configuration

    aws.access_key_id = "ACCES_KEY_ID"
    aws.secret_access_key = "SECRET_ACCESS_KEY"  
    aws.security_groups = [ 'SECURITY_GROUP' ]

    aws.region_config "eu-west-1" do |region|
      region.ami = "ami-61e56916"  
      region.keypair_name = "KEYPAIR_NAME"
      instance_type = "m3.medium"
    end

    override.ssh.username = "admin"
    override.ssh.private_key_path = "PRIVATE_KEY_PATH"
  
  end

  config.vm.provision :shell, :inline => "export DEBIAN_FRONTEND=noninteractive && sleep 5 && apt-get update && apt-get install -y puppet"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "deploy/puppet/manifests"
    puppet.module_path = "deploy/puppet/modules"
    puppet.options = "--fileserverconfig=/vagrant/deploy/fileserver.conf" 
    #puppet.options = "--verbose --debug "
  end
 
end

