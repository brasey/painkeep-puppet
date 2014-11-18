class painkeep::service {

  require painkeep
  require painkeep::params

  service { 'painkeep':
    ensure      => running,
    enable      => true,
    hasstatus   => true,
    hasrestart  => true,
  }

}
