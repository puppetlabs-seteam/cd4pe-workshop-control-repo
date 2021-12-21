# Here are the modules that we need, in order to configure the workshop environment.

# CD4PE and dependencies
mod 'puppetlabs-cd4pe',                 '2.0.1'
mod 'puppetlabs-cd4pe_jobs',            :latest
mod 'puppetlabs-concat',                :latest
mod 'puppetlabs-hocon',                 :latest
mod 'puppetlabs-puppet_authorization',  :latest
mod 'puppetlabs-stdlib',                :latest
mod 'puppetlabs-docker',                :latest
mod 'puppetlabs-apt',                   :latest
mod 'puppetlabs-translate',             :latest

# For the workshop infrastructure profiles
mod 'pltraining/rbac',                  :latest
mod 'puppet/gitlab',                    :latest
mod 'puppetlabs/vcsrepo',               :latest
mod 'whatsaranjit/node_manager',        :latest
mod 'puppetlabs/inifile',               :latest

# Here's the module that we'll integrate into our CD4PE environment
mod 'mymodule',
  :git            => 'git@gitlab.se.automationdemos.com:puppet/puppet-mymodule-' + `facter --external-dir /opt/puppetlabs/facter/facts.d student_id`.chomp.to_s + '.git',
  :branch         => :control_branch,
  :default_branch => 'production'
