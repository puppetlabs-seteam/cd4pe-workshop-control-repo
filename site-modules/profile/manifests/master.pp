# This profile manages some resources on the master, to make life easier in
# the workshop.

class profile::master {

  # Need a user role that can do all the things that CD4PE needs.
  rbac_user { 'cd4pe':
    ensure       => present,
    name         => 'cd4pe',
    display_name => 'Continuous Delivery for Puppet Enterprise',
    email        => 'cd4pe@puppetlabs.vm',
    password     => 'puppetlabs',
    roles        => ['Continuous Delivery'],
    require      => Rbac_role['Continuous Delivery'],
  }
  rbac_role { 'Continuous Delivery':
    ensure      => present,
    description => 'Permissions required for CD4PE service account',
    permissions => [
      {
        'object_type' => 'node_groups',
        'action'      => 'edit_config_data',
        'instance'    => '*'
      },
      {
        'object_type' => 'node_groups',
        'action'      => 'set_environment',
        'instance'    => '*'
      },
      {
        'object_type' => 'puppetserver',
        'action'      => 'compile_catalog',
        'instance'    => '*'
      },
      {
        'object_type' => 'node_groups',
        'action'      => 'view',
        'instance'    => '*'
      },
      {
        'object_type' => 'puppet_agent',
        'action'      => 'run',
        'instance'    => '*'
      },
      {
        'object_type' => 'orchestrator',
        'action'      => 'view',
        'instance'    => '*'
      },
      {
        'object_type' => 'environment',
        'action'      => 'deploy_code',
        'instance'    => '*'
      },
      {
        'object_type' => 'nodes',
        'action'      => 'view_data',
        'instance'    => '*'
      },
      {
        'object_type' => 'node_groups',
        'action'      => 'modify_children',
        'instance'    => '*'
      },
      {
        'object_type' => 'tasks',
        'action'      => 'run',
        'instance'    => 'cd4pe_jobs::run_cd4pe_job'
      }
    ]
  }

  # Let anyone set their environment on a run, for easy feature branch testing
  node_group { 'Agent-specified environment':
    ensure               => present,
    description          => 'Let anyone specify their environment.  Why not?',
    environment          => 'agent-specified',
    override_environment => 'true',
    parent               => 'All Environments',
    rule                 => ['and',
    ['~',
      ['fact', 'agent_specified_environment'],
      '.*']],
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
