require 'spec_helper'

describe 'sudosh' do

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      let(:facts) do
        facts
      end

      context "on #{os}" do
        it { is_expected.to create_class('sudosh') }
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('sudosh2') }

        it do
          is_expected.to contain_rsyslog__rule__local('0sudosh').with({
            'rule' => "if ($programname == \'sudosh\') then",
            'target_log_file' => '/var/log/sudosh.log',
            'stop_processing' => true
          })
        end

        it do
          is_expected.to contain_logrotate__add('sudosh').with({
            'log_files' => ['/var/log/sudosh.log'],
            'missingok' => true,
            'lastaction' => '/sbin/service rsyslog restart > /dev/null 2>&1 || true'
          })
        end
      end
    end
  end
end
