require 'spec_helper'

describe 'simp' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts){ facts.merge({
        :fqdn     => 'foo.bar.baz',
        :hostname => 'foo',
      })}

      before(:each) do
        mod_site_pp("hiera_include('classes')")
      end

      it { should compile.with_all_deps }

      context 'with_puppet_server' do
        let(:params) {{ :puppet_server_ip => '1.2.3.4' }}

        it { should create_host('puppet.bar.baz').with_ip('1.2.3.4') }
      end
    end
  end
end
