# This class gets targeted to all nodes (via /manifests/site.pp)
# Use this class for testing changes

class profile::common(
    Array[String] $packages = [ 'nano', 'vim-enhanced' ]
){

    package { $packages:
        ensure => present
    }

}
