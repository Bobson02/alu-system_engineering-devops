# Install NginX
# With puppet

exec { 'apt-get-update':
  command => '/usr/bin/apt-get update',
}

package { 'nginx':
  ensure  => installed,
  require => Exec['apt-get-update'],
}

file { '/usr/share/nginx/html/index.html':
  content => 'Holberton School',
  require => Package['nginx'],
}

exec {'redirect_me':
  command  => 'sed -i "24i\	rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;" /etc/nginx/sites-available/default',
  provider => 'shell'
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}