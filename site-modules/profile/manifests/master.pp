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
  
  # Get all current classes first
  $pe_master_classes = node_groups('PE Master')['PE Master']['classes']
  
  # Define updated puppet_enterprise::profile::master class
  $code_manager_hash = {
    'puppet_enterprise::profile::master' => {
      'code_manager_auto_configure' => true,
      'r10k_private_key'            => '/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa',
      'r10k_remote'                 => "https://student0:puppetlabs@gitlab.classroom.puppet.com/puppet/control-repo-${profile::human_number()}.git",
      'replication_mode'            => 'none'
    }
  }
  
  # Merge hashes to override puppet_enterprise::profile::master class
  $pe_master_new_classes = $pe_master_classes + $code_manager_hash
  
  # Apply to new config to the node group
  node_group { 'PE Master':
    ensure               => present,
    classes              => $pe_master_new_classes,
    environment          => 'production',
    override_environment => 'false',
    parent               => 'PE Infrastructure',
    rule                 => ['or',
    ['=', 'name', 'puppet.classroom.puppet.com']],
  }

}
