# painkeep

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [painkeep]](#setup)
    * [What [painkeep] affects](#what-[modulename]-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with [painkeep]](#beginning-with-[painkeep])
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Install a Painkeep server.

## Module Description

Painkeep was a very popular mod of Quake (the original) back in the day. Wouldn't it be cool to set up a server?

This module will install a Team Fortress hack of mvdsv. mvdsv is a QuakeWorld server that supports recording multi-view (from each player and free view). This is a neat feature that allows you to auto-record demos for all games played. Neat! There is an 'official' version of mvdsv that is more current (last updated in 2013 as opposed to 2011), but it breaks the physics of tossing goodies, which you do a lot of in Painkeep.

The binaries for TF mvdsv are at [at this link](http://avirox.tfgames.org/Releases/Server/MVDSV%20XE/).

The Painkeep mod has been worked on periodically over the years, and this work is included here.

Links to all the Painkeep things you need are [at Weenieville](http://wv.no-ip.biz/).

I've written this Puppetry to run on Linux, and it has only been tested on Fedora 20.
    

## Setup

### What [painkeep] affects

The server binaries will go in /srv/painkeep.

There is an init file at /etc/init.d/painkeep. Use it like this:

```shell
sudo service painkeep start
sudo service painkeep stop
sudo service painkeep status
```

There is a weekly cron job that restarts the server. This is necessary due to a bug in the harpoon code that crashes the server every so often.


### Setup Requirements

Puppet Forge modules:
  * maestrodev-wget

Quake is still licensed software. To run a Quake server, you'll need a couple of files from your original Quake install media:
  * id/pak0.pak
  * id/pak1.pak

A hieradata file that holds a few key value pairs and a user definition. It should look like this:

```YAML
---
painkeepdir: '/srv/painkeep'
idpak0url: 'https://www.example.com/pak0.pak'
idpak1url: 'https://www.example.com/pak1.pak'
contact_email: 'user@example.com'
contact_url: 'http://www.example.com'
banner: 'Weenieville Painkeep Modified'
rcon_password: 'password'
demodir: '/pkdemos'
default_playername: 'turdburglar'


painkeep_users:
  painkeep:
    ensure: present
    uid: 1001
    gid: 1001
    comment: 'Painkeep service account'
    groups:
      - painkeep
    managehome: false
    password: '!'
    shell: '/usr/sbin/nologin'
```

	
### Beginning with [painkeep]	

Once you have that yaml file set up, make sure it's in the same place as the modules. Then, you should be able to run

```shell
puppet apply --modulepath=/path/to/modules --hiera_config=/path/to/modules/hiera.yaml /path/to/site.pp
```

and have a Painkeep server up and running in a jif.


##Reference

```ascii
.
├── COPYING
├── files
│   ├── 1v1.dat
│   ├── burrito_mode.dat
│   ├── covrotation.cfg
│   ├── fastrotation.cfg
│   ├── mvdsv
│   ├── painkeep-initscript
│   ├── qwprogs.dat
│   └── qwprogs_zany.dat
├── manifests
│   ├── init.pp
│   ├── params.pp
│   └── user.pp
├── README.md
└── templates
    └── server.cfg.erb
```


##Limitations

This module has only been tested on Fedora 20.


##Development

This modules lives at https://github.com/brasey/painkeep. Please feel free to raise issues, contribute code, fork, whatever.
