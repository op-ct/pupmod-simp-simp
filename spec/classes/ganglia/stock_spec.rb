require 'spec_helper'

describe 'simp::ganglia::stock' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      base_facts = {
#        :fqdn => 'spec.test',
#        :interfaces => 'lo',
#        :ipaddress_lo => '127.0.0.1',
#        :processorcount => 4,
#        :uid_min => '500',
#        :apache_version => '2.2',
#        :init_systems => ['rc','sysv','upstart'],
#        :selinux_current_mode => 'enforcing',
        :trusted => {
          :certname => 'foo.bar.baz'
        },
      }
      let(:facts){ facts.merge(base_facts)}

      describe "a fact set ganglia" do
        it { should create_class('simp::ganglia::monitor') }
        it { should create_class('simp::ganglia::meta') }
        it { should create_class('simp::ganglia::web') }
      end
    end
  end
end
