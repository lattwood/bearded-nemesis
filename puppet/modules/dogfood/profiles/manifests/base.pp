
class profiles::base () {
  class { '::ntp': }

  class { '::scl::python33':
    before => Package['python33']
  }

  package { 'python33':
    ensure => present
  }

}
