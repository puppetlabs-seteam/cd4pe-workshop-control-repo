# Here are the modules that we need, in order to configure the workshop
# environment.


# CD4PE and dependencies
mod 'puppetlabs-cd4pe', :latest
mod 'puppetlabs-concat', '4.2.1'
mod 'puppetlabs-hocon', '1.0.1'
mod 'puppetlabs-puppet_authorization', '0.5.0'
mod 'puppetlabs-stdlib', '4.25.1'
mod 'puppetlabs-docker', '3.3.0'
mod 'puppetlabs-apt', '6.2.1'
mod 'puppetlabs-translate', '1.1.0'

# For the workshop infrastructure profiles
mod 'pltraining/rbac'
mod 'puppet/gitlab'
mod 'puppetlabs/vcsrepo'
mod 'whatsaranjit/node_manager'
mod 'puppetlabs/inifile'

# Here's the module that we'll integrate into our CD4PE environment
mod 'cd4pe/mymodule',
  :git            =>  'git@gitlab.classroom.puppet.com:puppet/puppet-mymodule-' + `hostname`.match('\d+').to_s,
  :branch         => :control_branch,
  :default_branch => 'production'
