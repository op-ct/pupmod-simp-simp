require 'spec_helper'

describe 'simp::nfs::home_client' do
  on_supported_os.each do |os, facts|
    let(:facts){ facts.merge({
      :selinux              => true,
      :selinux_current_mode => :enforcing,
      :selinux_state        => :enforcing,
    })}
    context "on #{os}" do
      it { should create_class('simp::nfs::home_client') }
      it { should compile.with_all_deps }
      it { should contain_class('nfs') }
      it { should contain_class('nfs::client') }
      it { should contain_class('autofs') }
      it { should contain_selboolean('use_nfs_home_dirs') }
    end
  end
end
