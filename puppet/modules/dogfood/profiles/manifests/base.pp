
class profiles::base () {
  class { '::ntp': }

  package { 'chef':
    ensure => purged
  }

}
