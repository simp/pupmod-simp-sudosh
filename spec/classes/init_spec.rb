require 'spec_helper'

describe 'sudosh' do

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      let(:facts) do
        facts
      end

      context "on #{os}" do
        context 'default parameters' do
          it { is_expected.to create_class('sudosh') }
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('sudosh2') }
          it { is_expected.to_not contain_rsyslog__rule__local('XX_sudosh') }
          it { is_expected.to_not contain_logrotate__rule('sudosh') }
        end

        context 'with syslog and logrotate enabled' do
          let(:params) {{ :syslog => true, :logrotate => true }}
          it { is_expected.to create_class('sudosh') }
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('sudosh2') }

          it do
            is_expected.to contain_rsyslog__rule__local('XX_sudosh').with({
              'rule' => "$programname == \'sudosh\'",
              'target_log_file' => '/var/log/sudosh.log',
              'stop_processing' => true
            })
          end

          it do
            is_expected.to contain_logrotate__rule('sudosh').with({
              'log_files'                 => ['/var/log/sudosh.log'],
              'missingok'                 => true,
              'lastaction_restart_logger' => true
            })
          end
        end
      end
    end
  end
end
