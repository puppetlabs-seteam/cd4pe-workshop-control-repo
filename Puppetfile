# This function enables CD4PE to do Impact Analysis on custom modules

def default_branch(default)
  begin
    match = /(.+)_(cdpe|cdpe_ia)_\d+$/.match(@librarian.environment.name)
    match ? match[1]:default
  rescue
    default
  end
end

# Here are the modules that we need, in order to configure the workshop environment.

# CD4PE and dependencies
mod 'puppetlabs-cd4pe',                 :latest
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
  :git            => 'https://student0:puppetlabs@gitlab.classroom.puppet.com/puppet/puppet-mymodule-' + `facter --external-dir /opt/puppetlabs/facter/facts.d student_id`.chomp.to_s + '.git',
  :branch         => :control_branch,
  :default_branch => default_branch('production')
