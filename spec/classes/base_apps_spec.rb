require 'spec_helper'

describe 'simp::base_apps' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      base_facts = {
        :operatingsystem => 'CentOS',
        :lsbmajdistrelease => '6',
        :lsbdistrelease => '6.5',
        :ipaddress => '10.10.10.10',
        :fqdn => 'foo.bar.baz',
        :hostname => 'foo',
        :interfaces => 'eth0',
        :ipaddress_eth0 => '10.10.10.10',
        :trusted => {
          :certname => 'foo.bar.baz'
        },
        :passenger_version => '4',
        :selinux_current_mode => 'enforcing',
        :grub_version => '0.9',
        :uid_min => '500',
        :apache_version => '2.2',
        :init_systems => ['rc','sysv','upstart']
      }

      let(:facts){ facts.merge(base_facts)}

      it { should create_class('simp::base_apps').with_ensure('latest') }
      it { should compile.with_all_deps }
    end
  end
end
