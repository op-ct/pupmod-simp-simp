# @summary Set up a yum server
#
# @param data_dir
#   Path to web server directory, where the `yum` directory will be established
#
# @param trusted_nets
#   Networks allowed to access the yum server
#
# @param createrepo_ensure
#   Strategy to manage the `createrepo` version. Can be 'latest' or 'installed'
#
# @author https://github.com/simp/pupmod-simp-simp/graphs/contributors
#
class simp::server::yum (
  Stdlib::Absolutepath $data_dir          = '/var/www',
  Simplib::Netlist     $trusted_nets      = simplib::lookup('simp_options::trusted_nets', { 'default_value' => ['127.0.0.1','::1'] }),
  String               $createrepo_ensure = simplib::lookup('simp_options::package_ensure', { 'default_value' => 'installed' }),
) {

  simplib::module_metadata::assert($module_name, { 'blacklist' => ['Windows'] })

  $_trusted_nets = simplib::nets2cidr($trusted_nets)

  include 'simp_apache'
  simp_apache::site { 'yum':
    content => template('simp/etc/httpd/conf.d/yum.conf.erb')
  }

  if $data_dir != '/var/www' {
    file { '/var/www/yum':
      ensure => 'link',
      target => "${data_dir}/yum"
    }

    file { $data_dir:
      ensure => 'directory',
      owner  => 'root',
      group  => 'apache',
      mode   => '0750'
    }
  }

  package { 'createrepo':
    ensure => $createrepo_ensure,
  }
}
