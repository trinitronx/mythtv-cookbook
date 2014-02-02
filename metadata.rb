name             'mythtv'
maintainer       'Chris Peplin'
maintainer_email 'chris.peplin@rhubarbtech.com'
license          'Apache 2.0'
description      'Installs/configures MythTV packages'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '0.0.1'

recipe 'mythtv', 'Installs/Configures mythtv repos'
recipe 'frontend', 'Installs/Configures mythfrontend'
recipe 'backend', 'Installs/Configures mythbackend'

supports 'ubuntu'

depends 'mysql'
depends 'apt'
depends 'ubuntu'
