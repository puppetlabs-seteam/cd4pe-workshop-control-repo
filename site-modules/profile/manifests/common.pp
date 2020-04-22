# This class gets targeted to all nodes (via /manifests/site.pp)
# Use this class for testing changes

class profile::common(
    Hash $packages = {}
){

    $packages.each |$package,$attribs| {
        package { $package:
            * => $attribs
        }
    }

}
