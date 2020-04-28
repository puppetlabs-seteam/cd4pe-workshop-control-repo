# This fix overrides the cd4pe repo's baseurl, so that it matches the SSL certificate name
# Also fixes an SElinux change happening after the initial cd4pe install run

class profile::cd4pe {

  $pe_ver  = pe_build_version()
  $base_source = 'https://puppet.classroom.puppet.com:8140/packages'
  $source = "${base_source}/${pe_ver}/puppet_enterprise"

  Yumrepo <| title == 'cd4pe' |> {
    baseurl => $source,
  }

  File <| (title == '/etc/systemd/system/docker.service.d/service-overrides.conf') or
          (title == '/etc/systemd/system/docker-cd4pe.service') |> {
    seltype => 'container_unit_file_t'
  }

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
