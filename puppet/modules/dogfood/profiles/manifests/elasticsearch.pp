
class profiles::elasticsearch () {

  class { '::elasticsearch':
    manage_repo  => true,
    repo_version => '1.2',
    java_install => true
  }

  elasticsearch::instance { 'es-01': }
}
