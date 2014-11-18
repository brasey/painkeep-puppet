# == Class: painkeep
#
# This class installs a fully functional Painkeep server.
#
# === Authors
#
# Bob Rasey <brasey@gmail.com>
#
# === Copyright
#
# Copyright 2014 Bob Rasey, distributed under the terms of
# the GNU General Public License.
# See the COPYING file.
#


class painkeep {

  include wget
  include painkeep::service

  require painkeep::params
  require painkeep::user

  $painkeepdir = $painkeep::params::painkeepdir

  File {
    owner       => 'painkeep',
    group       => 'painkeep',
    mode        => '0664',
  }

  Wget::Fetch {
    timeout     => 0,
    verbose     => false,
  }

  file { [
          '/srv',
          $painkeepdir,
          "${painkeepdir}/id1",
          "${painkeepdir}/Painkeep",
          "${painkeepdir}/qw",
          ]:
    ensure      => directory,
    mode        => '0775',
  }

# The id Software pak files from Quake are licensed software.
# Include a link URL to each of these in a hiera file.

  wget::fetch { 'fetch id pak0.pak':
    source      => $painkeep::params::idpak0url,
    destination => "${painkeepdir}/id1/pak0.pak",
    require     => File[ $painkeepdir ],
  }

  wget::fetch { 'fetch id pak1.pak':
    source      => $painkeep::params::idpak1url,
    destination => "${painkeepdir}/id1/pak1.pak",
    require     => File[ $painkeepdir ],
  }


# This zip file has all the Painkeep things you need.
# Thanks SH!

  wget::fetch { 'fetch Painkeep monster zip':
    source      => $painkeep::params::painkeepzipurl,
    destination => "/tmp/${painkeep::params::painkeepzipfile}",
    require     => File[ $painkeepdir ],
  }

  exec { 'explode Painkeep monster zip':
    command     => "${painkeep::params::unzip} /tmp/${painkeep::params::painkeepzipfile} -d ${painkeepdir}",
    user        => 'painkeep',
    creates     => "${painkeepdir}/Painkeep/vwep.pk3",
    require     => Wget::Fetch[ 'fetch Painkeep monster zip' ],
  }


# This tarball contains the qw directory and contents

  wget::fetch { 'fetch qw dir tarball':
    source      => 'https://www.dropbox.com/s/39bpnxgs45yzdys/qwdir.tgz',
    destination => '/tmp/qwdir.tgz',
    require     => File[ $painkeepdir ],
  }

  exec { 'explode qw dir tarball':
    command     => "${painkeep::params::tar} /tmp/qwdir.tgz -d ${painkeepdir}",
    user        => 'painkeep',
    creates     => "${painkeepdir}/qw/textures",
    require     => Wget::Fetch[ 'fetch qw dir tarball' ],
  }


# These are the most current Painkeep dat files. This is where all the fun is!

  file { "${painkeepdir}/Painkeep/qwprogs.dat":
    ensure      => file,
    source      => 'puppet:///modules/painkeep/qwprogs.dat',
    require     => File[ "${painkeepdir}/Painkeep" ],
  }

  file { "${painkeepdir}/Painkeep/qwprogs_zany.dat":
    ensure      => file,
    source      => 'puppet:///modules/painkeep/qwprogs_zany.dat',
    require     => File[ "${painkeepdir}/Painkeep" ],
  }

  file { "${painkeepdir}/Painkeep/1v1.dat":
    ensure      => file,
    source      => 'puppet:///modules/painkeep/1v1.dat',
    require     => File[ "${painkeepdir}/Painkeep" ],
  }

  file { "${painkeepdir}/Painkeep/burrito_mode.dat":
    ensure      => file,
    source      => 'puppet:///modules/painkeep/burrito_mode.dat',
    require     => File[ "${painkeepdir}/Painkeep" ],
  }


# This is the server binary

  file { "${painkeepdir}/mvdsv":
    ensure      => file,
    source      => 'puppet:///modules/painkeep/mvdsv',
    mode        => '0775',
    require     => File[ $painkeepdir ],
  }


# Some good map rotations

  file { "${painkeepdir}/Painkeep/covrotation.cfg":
    ensure      => file,
    source      => 'puppet:///modules/painkeep/covrotation.cfg',
    require     => File[ "${painkeepdir}/Painkeep" ],
  }

  file { "${painkeepdir}/Painkeep/fastrotation.cfg":
    ensure      => file,
    source      => 'puppet:///modules/painkeep/fastrotation.cfg',
    require     => File[ "${painkeepdir}/Painkeep" ],
  }


# The server config built from a template

  file { "${painkeepdir}/Painkeep/server.cfg":
    ensure      => 'file',
    content     => template('painkeep/server.cfg.erb'),
    require     => File[ "${painkeepdir}/Painkeep" ],
  }


# And an init script to make it go and stop

  file { '/etc/init.d/painkeep':
    ensure      => file,
    source      => 'puppet:///modules/painkeep/painkeep-initscript',
  }


# We need to install and configure monit
# There's a bug when the harpoon sticks in a door or lift that
# sometimess causes the server to crash.

  package { $painkeep::params::monit:
    ensure      => latest,
  }

  file { '/etc/monit.d/painkeep':
    ensure      => file,
    source      => 'puppet:///modules/painkeep/painkeep-monit',
    require     => Package[ $painkeep::params::monit ],
  }

}
