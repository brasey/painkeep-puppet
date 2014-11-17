class painkeep::params {

  $painkeepdir        = hiera('painkeepdir', '/srv/painkeep')
  $idpak0url          = hiera('idpak0url')
  $idpak1url          = hiera('idpak1url')
  $contact_email      = hiera('contact_email')
  $contact_url        = hiera('contact_url')
  $banner             = hiera('banner')
  $rcon_password      = hiera('rcon_password')
  $demodir            = hiera('demodir')
  $default_playername = hiera('default_playername')

}
