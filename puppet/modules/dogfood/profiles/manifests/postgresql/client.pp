
class profiles::postgresql::client ( ) inherits profiles::postgresql
{
  class { '::postgresql::client': }
}
