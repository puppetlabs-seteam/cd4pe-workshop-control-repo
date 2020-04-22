# This fix overrides the cd4pe repo's baseurl, so that it matches the SSL certificate name
# Also ensures the cd4pe_version is set to '3.x', in case the student forgets

class profile::cd4pe {

  $pe_ver  = pe_build_version()
  $base_source = "https://puppet.classroom.puppet.com:8140/packages"
  $source = "${base_source}/${pe_ver}/puppet_enterprise"

  Yumrepo <| title == 'cd4pe' |> {
    baseurl => $source,
  }

  Class <| title == 'cd4pe' |> {
    cd4pe_version => '3.x'
  }
}
