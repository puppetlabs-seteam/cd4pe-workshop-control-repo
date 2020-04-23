# Default node resources
node default {
  include profile::common
}

# Any node that starts with 'master' is a primary master for a participant
node /^master/, /^puppet/ {
  include profile::common
  include profile::master
}

node /cd4pe\d+.classroom.puppet.com/ {
  include profile::common
  include profile::cd4pe
}
