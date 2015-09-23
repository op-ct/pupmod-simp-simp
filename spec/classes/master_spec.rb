require 'spec_helper'

describe 'pupmod::master' do
  shared_examples_for "a fact set master" do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('apache') }
    it { is_expected.to contain_class('pupmod') }
    it { is_expected.to contain_class('pupmod::master') }
    it { is_expected.to contain_class('pupmod::master::base') }
  end

  context 'on supported operating systems' do
    on_supported_os.each do |os, facts|
      let(:facts){ facts.merge( {
                :apache_version       => '2.2',
                :fqdn                 => 'test.host.simp',
                :passenger_root       => '/usr/lib/ruby/gems/1.8/gems/passenger',
                :passenger_version    => '4',
                :selinux_current_mode => 'enabled',
                :trusted              => { 'certname' => 'spec.test' },
              })
      }

      context "on #{os}" do
        context 'with FIPS enabled' do
          let(:facts) { facts.merge({ :fips_enabled => true }) }
          it { is_expected.to contain_ini_setting('pupmod_keylength').with_value( '2048' ) }
          it_behaves_like "a fact set master"
        end
        context 'with FIPS disabled' do
          let(:facts) { facts.merge({ :fips_enabled => false }) }
          it { is_expected.to contain_ini_setting('pupmod_keylength').with_value( '4096' ) }
        end
      end
    end
  end
end
