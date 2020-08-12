# == Class: sssd::service
# Control the SSSD services
#
# @author https://github.com/simp/pupmod-simp-sssd/graphs/contributors
#
class sssd::service {

  case $facts['os']['name'] {
    'RedHat','CentOS','OracleLinux': {
      file { '/etc/init.d/sssd':
        ensure  => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        seltype => 'sssd_initrc_exec_t',
        source  => 'puppet:///modules/sssd/sssd.sysinit',
        notify  => Service['sssd']
      }
    }
    'Ubuntu': {
      file { '/etc/init.d/sssd':
        ensure  => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        seltype => 'sssd_initrc_exec_t',
        source  => 'puppet:///modules/sssd/ubuntu/sssd.sysinit',
        notify  => Service['sssd']
      }
      file { '/etc/default/sssd':
        ensure  => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        source  => 'puppet:///modules/sssd/ubuntu/sssd.default',
        notify  => Service['sssd']
      }
    }
    default: {
      fail("${::operatingsystem} is not yet supported by ${module_name}")
    }
  }

  service { 'nscd':
    ensure => 'stopped',
    enable => false,
    notify => Service['sssd']
  }

  service { 'sssd':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
