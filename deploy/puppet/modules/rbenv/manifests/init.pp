# == Class: rbenv

class rbenv {
  
  include rbenv::dependencies

  $user     = 'deploy'
  $group    = 'nogroup'
  $home_dir = "/home/${user}"
  $version  = '1.9.3-p448'
  
  rbenv::install { "rbenv::install::${user}":
    user       => $user,
    group      => $group,
    home       => $home_dir,
    require    => User["${user}"],
  }
  
 rbenv::compile { "1.9.3-p448":
   user        => $user,
   group       => $group,
   home        => $home_dir,
   global      => true,
 } 
  
 rbenv::gem { "rake":
   user        => $user,
   ruby        => $version,
 }
 rbenv::gem { "bundle":
   user        => $user,
   ruby        => $version,
 }
 rbenv::gem { "rails":
   user        => $user,
   ruby        => $version,
  }

}