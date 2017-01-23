# sudosh class
#
# This class installs sudosh and optionally configures rsyslog and logrotate.
#
# @param syslog Whether to include SIMP's ::rsyslog class and use it to create
#   a specific log file for sudosh (/var/log/sudosh.log)
#
# @param logrotate Whether to include SIMP's logrotate class and to use it
#   to create a log rotate rule for the sudosh log file.
#
# @example Ensuring all sudo operations are run with sudosh
#   Insert the following code in an appropriate manifest (e.g.,
#   /etc/puppet/manifests/nodes/default_classes/base_config.pp).
#
#     sudo::user_specification { 'global_admin':
#       user_list => '%administrators',
#       host_list => 'ALL',
#       runas => 'ALL',
#       cmnd => '/usr/bin/sudosh',
#       passwd => 'false'
#     }
#
# @author Trevor Vaughan <tvaughan@onyxpont.com>
#
class sudosh (
  Boolean $syslog    = simplib::lookup('simp_options::syslog', { 'default_value' => false }),
  Boolean $logrotate = simplib::lookup('simp_options::logrotate', { 'default_value' => false })
) {

  # This package is from the SIMP repo
  package { 'sudosh2':
    ensure => 'latest'
  }

  if $syslog {
    include '::rsyslog'
    # named 'XX_sudosh' so that it appears before the local filesystem defaults
    rsyslog::rule::local { 'XX_sudosh':
      rule            => '$programname == \'sudosh\'',
      target_log_file => '/var/log/sudosh.log',
      stop_processing => true
    }

    # Don't forget the logrotate rule!
    if $logrotate {
      include '::logrotate'
      logrotate::rule { 'sudosh':
        log_files  => [ '/var/log/sudosh.log' ],
        missingok  => true,
        lastaction => '/sbin/service rsyslog restart > /dev/null 2>&1 || true'
      }
    }
  }
}
