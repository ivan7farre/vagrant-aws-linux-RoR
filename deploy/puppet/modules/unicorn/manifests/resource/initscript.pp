# == Define: resque init definitions
#
# Definition for unicorn init scripts
#
# === Parameters:
#
# === Actions:
#
# === Requires:
#
define unicorn::resource::initscript (
  $ensure = 'present',
  $user   = 'deploy',
  $app,
  $environment,
) {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0755',
  }

  #case $environment {
  #  production: { $env_abreviation = 'prod'                         }
  #  staging:    { $env_abreviation = 'stage'                        }
  #  sandbox:    { $env_abreviation = 'sand'                         }
  #  qa:         { $env_abreviation = 'qa'                           }
  #  default:    { notice('Wrong environment addigned on unicorn')   }
  #}

  #file { "/etc/init.d/unicorn-${env_abreviation}-${app}":
  file { "/etc/init.d/unicorn-${app}":
    ensure  => $ensure ? {
      'absent' => absent,
      default  => 'file',
    },
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("unicorn/unicorn.erb")
  }
    
}
