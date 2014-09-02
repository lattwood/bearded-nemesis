
class profiles::postgresql::server ( ) inherits profiles::postgresql
{
  class { '::postgresql::server':
    ip_mask_deny_postgres_user => '0.0.0.0/32',
    ip_mask_allow_all_users    => '0.0.0.0/0',
    listen_addresses           => '*',
    manage_firewall            => true,
    postgres_password          => 'trololol',
  }
}
