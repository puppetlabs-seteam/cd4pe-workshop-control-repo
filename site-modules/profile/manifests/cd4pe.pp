# This fix overrides the cd4pe repo's baseurl, so that it matches the SSL certificate name

class profile::cd4pe {

  $pe_ver  = pe_build_version()
  $base_source = "https://puppet.classroom.puppet.com:8140/packages"
  $source = "${base_source}/${pe_ver}/puppet_enterprise"

  Yumrepo <| title == 'cd4pe' |> {
    baseurl => $source,
  }
}
