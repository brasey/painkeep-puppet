class painkeep::user {

  group { 'painkeep':
    ensure  => present,
  }

  user { 'painkeep':
    ensure    => present,
    comment   => 'Painkeep service account',
    password  => '!',
    shell     => '/sbin/nologin',
  }

}
