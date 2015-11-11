require 'spec_helper'

describe 'simp::freeradius::stock_ldap' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      base_facts = {
        :lsbmajdistrelease => '6',
        :lsbdistrelease => '6.6',
        :operatingsystem => 'RedHat',
        :hardwaremodel => 'x86_64',
        :passenger_version => '4',
        :selinux_current_mode => 'enforcing',
        :grub_version => '0.9',
        :uid_min => '500',
        :apache_version => '2.2',
        :init_systems => ['rc','sysv','upstart'],
        :interfaces => 'eth0',
        :trusted => {
          :certname => 'foo.bar.baz'
        }
      }

      let(:facts){ facts.merge(base_facts)}

      it { should create_class('simp::freeradius::stock_ldap') }
      it { should compile.with_all_deps }
      it { should create_file('/etc/raddb/modules/ldap') }
    end
  end
end
