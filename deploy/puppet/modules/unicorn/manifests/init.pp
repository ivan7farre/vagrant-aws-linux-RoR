# == Class unicorn
#
class unicorn {

  if ! defined(File['/var/www']) { file { '/var/www': ensure => 'directory', owner => 'deploy', group => 'nogroup', mode => '0755' } }

  file { [ '/var/run/unicorn',
    '/var/run/unicorn/pids',
    '/var/run/unicorn/sockets' ]:
      ensure => 'directory',
      owner  => 'deploy',
      group  => 'nogroup',
      mode   => '0755'
  }


  unicorn::resource::initscript {
    'unicorn-rest_api':
      app             => 'rest_api',
      environment     => 'staging';

  }


}
