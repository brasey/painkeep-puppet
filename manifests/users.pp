class painkeep::users {

  group { 'painkeep':
    ensure  => present,
  }

  user { 'painkeep':
    ensure    => present,
    comment   => 'Painkeep service account',
    password  => '!',
    shell     => '/sbin/nologin',
  }

  users { 'painkeep': }

}
