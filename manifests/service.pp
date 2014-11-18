class painkeep::service {

  require painkeep

  service { 'painkeep':
    ensure      => running,
    enable      => true,
    hasstatus   => true,
  }

  service { $painkeep::params::monit:
    ensure      => running,
    enable      => true,
    hasstatus   => true,
    hasrestart  => true,
  }

}
