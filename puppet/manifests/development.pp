# Stages
# -----------------------------------------------------------------------------

stage { 'before-rvm-install': 
  before => Stage['rvm-install']
}

stage { 'second':
 require => Stage['main']
}

stage { 'third':
 require => Stage['second']
}

# Classes
# -----------------------------------------------------------------------------

class requirements
{
  group { "puppet": ensure => "present", }

  exec { "apt-update":
    command => "/usr/bin/apt-get -y update"
  }

  if ! defined(Package["build-essential"])            { package { 'build-essential': ensure => installed, require => Exec["apt-update"] }}
  if ! defined(Package["zlib1g-dev"])                 { package { 'zlib1g-dev': ensure => installed, require => Exec["apt-update"] }}
  if ! defined(Package["curl"])                       { package { 'curl': ensure => installed, require => Exec["apt-update"] }}
  if ! defined(Package["libicu-dev"])                 { package { 'libicu-dev': ensure => installed, require => Exec["apt-update"] }}
}

class java
{
  package { jdk:
    ensure  => installed, 
    name => $operatingsystem ? {
      centOS => "java-1.6.0-openjdk-devel",
      Ubuntu => "openjdk-6-jdk",
      default => "jdk",
    },
    require => Exec["apt-update"]
  }

  $packages = [
     "xfonts-100dpi",
     "xfonts-75dpi",
     "xfonts-scalable",
     "xfonts-cyrillic"
  ]

  package { 
     $packages : ensure => installed, 
     require => Exec["apt-update"],
  }
}

class installrvm
{
  include rvm
  
  rvm::system_user { vagrant: }
}

class installruby
{
  rvm_system_ruby { 'ruby-2.0.0-p0':
    ensure => 'present'
  }
}

class installxvfb 
{
  include xvfb
}

# Go!
# -----------------------------------------------------------------------------

class { 'requirements': 
  stage => "before-rvm-install"
}

class { 'java': 
  stage => "before-rvm-install"
}

class { 'installrvm': }

class { 'installruby': 
  stage => second
}

class { 'installxvfb': 
  stage => second
}