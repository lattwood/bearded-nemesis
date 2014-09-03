
class profiles::web ()
{
  class { '::nginx': }

  class { '::hhvm':
    manage_repos => true,
    pgsql        => false
  }

  package { 'golang-go':
    ensure  =>  latest
  }

}
