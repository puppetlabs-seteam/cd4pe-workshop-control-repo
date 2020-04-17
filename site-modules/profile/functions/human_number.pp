# Quick and dirty function to pull the trailing digits from a node's hostname
# to reflect what human this node belongs to.

function profile::human_number >> String {

  if $facts['hostname'].match(/(\d+)$/) {
    $facts['hostname'].match(/(\d+)$/)[1]
  }
  else {
    'unknown'
  }

}
