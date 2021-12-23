# Set 24h run interval so that it doesn't interfere with the workshop

class profile::cd4pe {

  ini_setting { 'puppet[main:runinterval]':
    ensure            => present,
    section           => 'main',
    key_val_separator => '=',
    path              => '/etc/puppetlabs/puppet/puppet.conf',
    notify            => Service['puppet'],
    setting           => 'runinterval',
    value             => 86400,
  }

  service { 'puppet':
    ensure => running
  }
}
