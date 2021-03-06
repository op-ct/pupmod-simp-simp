# This is a set of applications that you will want on most systems
#
# @param ensure
#   The ``$ensure`` status of all of the included packages
#
#   * Version pinning is not supported
#   * If you need version pinning, do not include this class
#
# @param extra_apps
#   A list of other applications that you wish to install
#
# @param manage_elinks_config
#   Add some useful settings to the global elinks configuration
#
# @author Trevor Vaughan <tvaughan@onyxpoint.com>
#
class simp::base_apps (
  Enum['latest','absent','present'] $ensure               = 'latest',
  Optional[Array[String,1]]         $extra_apps           = undef,
  Boolean                           $manage_elinks_config = true
) {

  $core_apps = [
    'bind-utils',
    'bridge-utils',
    'dos2unix',
    'elinks',
    'hunspell',
    'lsof',
    'man',
    'man-pages',
    'mlocate',
    'pax',
    'pinfo',
    'sos',
    'star',
    'symlinks',
    'vim-enhanced',
    'words',
    'x86info'
  ]
  $apps = $extra_apps ? {
    Array   => $core_apps + $extra_apps,
    default => $core_apps
  }
  package { $apps: ensure => $ensure }


  if $manage_elinks_config {
    file { '/etc/elinks.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['elinks']
    }

    file_line { 'elinks_ui_lang':
      path => '/etc/elinks.conf',
      line => 'set ui.language = "System"'
    }

    file_line { 'elinks_css_disable':
      path => '/etc/elinks.conf',
      line => 'set document.css.enable = 0'
    }
  }
}
