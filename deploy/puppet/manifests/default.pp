# Basic Puppet manifest

Exec { path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/" ] }

user { "deploy":
    #gid        => 'deploy',
    managehome => true,
    ensure     => 'present',
    shell      => '/bin/bash'
}

class system-update {

  exec { 'apt-get update':
    command => 'apt-get update',
  }

  $sysPackages = [ "build-essential", "vim", "curl", "git", "sudo" ]
  package { $sysPackages:
    ensure => "installed",
    require => Exec['apt-get update'],
  }
  $devPackages = [ "ruby", "ruby-dev", "ruby-build", "libv8-dev", "libmysqlclient-dev" ]
  package { $devPackages:
    ensure => "installed",
    require => Exec['apt-get update'],
  }
}

file { 


  '/etc/sudoers':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    source  => 'puppet:///files/sudoers',
    require => Package['sudo'];
  '/var/www/rest_api':
    ensure  => directory,
    mode    => '0775',
    owner   => 'deploy',
    group   => 'nogroup';
  '/home/deploy/.ssh':
    ensure  => directory,
    mode    => '0755',
    owner   => 'deploy',
    group   => 'nogroup';
  '/home/deploy/.ssh/id_rsa':
    ensure  => present,
    mode    => '0600',
    owner   => 'deploy',
    group   => 'nogroup',
    source  => 'puppet:///files/id_rsa';
  '/home/deploy/.ssh/id_rsa.pub':
    ensure  => present,
    mode    => '0600',
    owner   => 'deploy',
    group   => 'nogroup',
    source  => 'puppet:///files/id_rsa.pub';
  '/home/deploy/.ssh/authorized_keys':
    ensure  => present,
    mode    => '0600',
    owner   => 'deploy',
    group   => 'nogroup',
    source  => 'puppet:///files/authorized_keys';
    #content  => template('keys/authorized_keys.erb';

}

class mysql-setup {
  include '::mysql::server'
  mysql::db { 'rest_api':
    user     => 'rest_api',
    password => 'rest_api',
    host     => 'localhost',
    grant    => ['ALL'],
  }
}

class nginx-setup {

  include nginx

  nginx::resource::upstream { 'rest_api':
    members => [
      'localhost:3000',
    ],
  }
  
  nginx::resource::vhost { 'rest_api':
    proxy => 'http://rest_api',
  }
}

include system-update
include rbenv
# capistrano-setup
include mysql-setup
include nginx-setup
include unicorn



