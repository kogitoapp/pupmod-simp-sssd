# Install the sssd-client package
#
# @param ensure
#   Ensure setting for 'sssd-client' package
#
# @author https://github.com/simp/pupmod-simp-sssd/graphs/contributors
#
class sssd::install::client (
  $ensure = $::sssd::install::package_ensure
){

  if $facts['os']['name'] in ['RedHat','CentOS','OracleLinux'] {
    $_package = 'sssd-client'
  }
  elsif $facts['os']['name'] in ['Ubuntu'] {
    $_package = 'sssd-common'
  }
  else {
    fail("OS '${facts['os']['name']}' not supported by '${module_name}'")
  }
  package { $_package:
    ensure => $ensure
  }
}
