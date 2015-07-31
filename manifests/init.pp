# == Class: sudosh
#
# This class installs sudosh and configures rsyslog and logrotate.
#
# == Parameters
#
# == Example
#
# (in /etc/puppet/manifests/nodes/default_classes/base_config.pp)
#     sudo::user_specification { 'global_admin':
#       user_list => '%administrators',
#       host_list => 'ALL',
#       runas => 'ALL',
#       cmnd => '/usr/bin/sudosh',
#       passwd => 'false'
#     }
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpont.com>
#
class sudosh {
  include '::logrotate'
  include '::rsyslog'

  package { 'sudosh2':
    ensure => 'latest'
  }

  # named '0sudosh' so that it appears before the defaults
  rsyslog::rule::local { '0sudosh':
    rule            => 'if ($programname == \'sudosh\') then',
    target_log_file => '/var/log/sudosh.log',
    include_stop    => true
  }


  # Don't forget the logrotate rule!
  logrotate::add { 'sudosh':
    log_files  => [ '/var/log/sudosh.log' ],
    missingok  => true,
    lastaction => '/sbin/service rsyslog restart > /dev/null 2>&1 || true'
  }
}
