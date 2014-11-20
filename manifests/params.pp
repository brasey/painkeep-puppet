class painkeep::params {

# Some file paths that you may have to set for your OS

  case $::operatingsystem {
    default:  {
      $unzip          = '/usr/bin/unzip'
      $unzip_package  = 'unzip'
      $tar            = '/usr/bin/tar'
      $glibc          = 'glibc.i686'
    }
  }

  $painkeepdir        = hiera('painkeepdir', '/srv/painkeep')
  $idpak0url          = hiera('idpak0url')
  $idpak1url          = hiera('idpak1url')
  $painkeepzipurl     = hiera('painkeepzipurl')
  $painkeepzipfile    = inline_template('<%= File.basename(@painkeepzipurl) %>')
  $contact_email      = hiera('contact_email')
  $contact_url        = hiera('contact_url')
  $banner             = hiera('banner')
  $rcon_password      = hiera('rcon_password')
  $demodir            = hiera('demodir')
  $default_playername = hiera('default_playername')

}
