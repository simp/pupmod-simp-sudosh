require 'spec_helper'

describe 'sudosh' do

  it { should create_class('sudosh') }

  it { should contain_package('sudosh2') }

  it do
    should contain_rsyslog__add_rule('0sudosh').with({
      'rule' => "\n\nif \$programname == 'sudosh' then \t\t /var/log/sudosh.log\n& ~\n"
    })
  end

  it do
    should contain_logrotate__add('sudosh').with({
      'log_files' => '/var/log/sudosh.log',
      'missingok' => true,
      'lastaction' => '/sbin/service rsyslog restart > /dev/null 2>&1 || true'
    })
  end

end
