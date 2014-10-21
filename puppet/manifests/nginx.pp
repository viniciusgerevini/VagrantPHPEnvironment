
class nginx {

  package { 'nginx':
    ensure => present
  }

  service { 'nginx':
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus => true,
    require => Package["nginx"],
    restart => '/etc/init.d/nginx reload'
  }

  # Disable sendfile (it can show some issues with vagrant and sharedfolders)

  file_line { 'nginx.conf':
    path  => '/etc/nginx/nginx.conf',
    line  => 'sendfile off;',
    match => 'sendfile (off|on);',
    require => Package[nginx]
  }

  # Copy virtual hosts to Nginx

  file { "nginx-conf-links":
    path => "/etc/nginx/sites-enabled",
    source => "/vagrant/nginx_sites",
    recurse => true,
    force => true,
    replace => true,
    require => Package['nginx']
  }

  # make /vagrant root of nginx

  file { "nginx-files-links":
    path => "/usr/share/nginx/www",
    target => "/vagrant",
    ensure => link,
    force => true,
    replace => true,
    notify => Service['nginx'],
    require => File['nginx-conf-links']
  }

}
