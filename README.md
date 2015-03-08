## Vagrant-aws devel

This repo use Vagrant to control and provision EC2 instance and configure development environment including nginx and unicorn resources to deploy a simple application in rails with capistrano.


Usage
-----

* Install vagrant using the installation instructions in the [Getting Started document](http://vagrantup.com/v1/docs/getting-started/index.html)
* Install AWS provider ``` $ vagrant plugin install vagrant-aws ```
* Clone this repository
* Update Vagrant file with your own configuration (AWS credentials, EC2 ami, security groups, etc..)
* After running ```vagrant up --provider=aws``` the box is set up using Puppet
* Modify puppet recipes as you wish
* Run puppet using ``` vagrant provision --provision-with puppet ```

