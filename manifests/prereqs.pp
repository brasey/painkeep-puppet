class painkeep::prereqs {

  package { $painkeep::params::unzip_package:
    ensure  => latest,
  }

  package { $painkeep::params::glibc:
    ensure  => latest,
  }

}
