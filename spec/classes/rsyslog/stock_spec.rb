require 'spec_helper'

describe 'simp::rsyslog::stock' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      base_facts = {
        :interfaces => 'eth0, lo',
        :hardwaremodel => 'x86_64',
        :operatingsystem => 'RedHat',
        :lsbmajdistrelease => '6',
        :lsbdistrelease => '6.6',
        :passenger_version => '4',
        :selinux_current_mode => 'enforcing',
        :grub_version => '0.9',
        :uid_min => '500',
        :apache_version => '2.2',
        :init_systems => ['rc','sysv','upstart'],
        :trusted => {
          :certname => 'foo.bar.baz'
        }
      }
      let(:facts){ facts.merge(base_facts)}

      it { should compile.with_all_deps }
      it { should create_class('rsyslog') }
      it { should create_class('simp::rsyslog::stock::log_shipper') }
    end
  end
end
