# Any node that starts with 'master' is a primary master for a participant
node /^master/, /^puppet/ {
  include profile::master
}

# Any node that starts with 'cd4pe' is a participant's cd4pe node
node /^cd4pe/ {
  include profile::cd4pe
}

# The shared GitLab server has a short hostname of 'gitlab'
node /^gitlab/ {
  include profile::gitlab
}
