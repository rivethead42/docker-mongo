include 'dummy_service'
include 'gosu'
file { '/data': 
  ensure => directory,
}

-> class {'::mongodb::server':
  port           => 27018,
  verbose        => true,
  service_manage => false,
  dbpath         => '/data/db',
}

file { '/docker-entrypoint-initdb.d':
  ensure => file,
}

file { '/usr/local/bin/docker-entrypoint.sh':
  ensure => file,
  source => 'https://raw.githubusercontent.com/docker-library/mongo/master/3.5/docker-entrypoint.sh',
  mode   => "a+x",
}

file { '/entrypoint.sh':
  ensure => link,
  target => '/usr/local/bin/docker-entrypoint.sh',
  require => File['/usr/local/bin/docker-entrypoint.sh'],
}
