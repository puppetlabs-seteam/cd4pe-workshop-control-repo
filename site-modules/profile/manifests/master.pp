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
    }],
  }

  # Let anyone set their environment on a run, for easy feature branch testing
  node_group { 'Agent-specified environment':
    ensure               => present,
    description          => 'Let anyone specify their environment.  Why not?',
    environment          => 'agent-specified',
    override_environment => true,
    parent               => 'All Environments',
    rule                 => ['and',
    ['~',
      ['fact', 'agent_specified_environment'],
      '.*']],
  }

  # Manage the "PE Master" group so that we can aim R10K at the correct
  # participant's control repository, from the profile::human_number function
  node_group { 'PE Master':
    ensure               => present,
    classes              => {
    'pe_repo::platform::el_7_x86_64'     => {},
    'pe_repo::platform::windows_x86_64'  => {},
    'puppet_enterprise::profile::master' => {
      'code_manager_auto_configure' => true,
      'r10k_private_key'            => '/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa',
      'r10k_remote'                 => "git@gitlab.classroom.puppet.com:puppet/control-repo-${profile::human_number()}",
      'replication_mode'            => 'none'
    }
  },
    environment          => 'production',
    override_environment => 'false',
    parent               => 'PE Infrastructure',
    rule                 => ['or',
    ['=', 'name', 'puppet.classroom.puppet.com']],
  }

}
