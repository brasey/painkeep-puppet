class painkeep::user {

  group { 'painkeep':
    ensure  => present,
    gid     => '1001',
  }

  user { 'painkeep':
    ensure    => present,
    comment   => 'Painkeep service account',
    password  => '!',
    shell     => '/sbin/nologin',
  }

}
