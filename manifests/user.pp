class painkeep::user {

  group { 'painkeep':
    ensure  => present,
    gid     => '1001',
  }

  user { 'painkeep':
    ensure    => present,
    uid       => '1001',
    gid       => '1001',
    comment   => 'Painkeep service account',
    password  => '!',
    shell     => '/sbin/nologin',
  }

}
