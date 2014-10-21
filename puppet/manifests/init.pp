import 'nginx.pp'
import 'mysql.pp'
import 'php.pp'


$mysql_password = "my password"

class init () {
  case $::operatingsystem {
    "ubuntu" : {

    }
    default : {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

  exec { "apt_update":
    command => "/usr/bin/apt-get update",
  }

  include nginx
  include mysql::server
  include phpfpm

}

include init
