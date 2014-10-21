class phpfpm
{
	$php_packages = ['php5-fpm', 'php5-mysql', 'php5-cli', 'php5-curl', 'php5-gd', 'php5-mcrypt']
	package { $php_packages : ensure => present, before => File_line['php.ini'] }

	file_line { 'php.ini':
		path  => '/etc/php5/fpm/php.ini',
		line  => 'cgi.fix_pathinfo = 0',
		match => '^;?cgi.fix_pathinfo'
	}

	file_line { 'www.conf':
		path  => '/etc/php5/fpm/pool.d/www.conf',
		line  => 'listen = /var/run/php5-fpm.sock',
		require => File_line['php.ini'],
		notify => Service['php5-fpm']
	}

	service { 'php5-fpm':
	    ensure => running,
	    enable => true
  	}


  	# bugfix: MCrypt and PHP FPM (mcrypt is missing)
  	file { 'enable-php-mcrypt':
	    path => '/etc/php5/fpm/conf.d/20-mcrypt.ini',
	    target => '/etc/php5/mods-available/mcrypt.ini',
	    ensure => link,
	    force => true,
	    replace => true,
	    notify => Service['php5-fpm'],
	    require => File_line['www.conf']
	}

}