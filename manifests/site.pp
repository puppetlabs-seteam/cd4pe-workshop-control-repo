# Default node resources
node default {
}

# Any node that starts with 'master' is a primary master for a participant
node /^master/, /^puppet/ {
  include profile::master
}

node /cd4pe\d+.classroom.puppet.com/ {
  include profile::cd4pe
}
