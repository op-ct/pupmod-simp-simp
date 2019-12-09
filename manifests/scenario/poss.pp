# @api private
#
# Configure a *minimal* system that can connect to a SIMP Puppet server.
#
# This class *does not* provide security for a system; it is merely designed
# to connect to a Puppet server and run puppet as an agent.
#
# This class requires no additional configuration to function.
#
# @summary The *Minimum* configuration required to connect to a SIMP Puppet server
#
# @param puppet_server_hosts_entry
#   Add a ``host`` entry for the Puppet server to the catalog
#
#   * This has no effect if the ``$server_facts`` Hash is not populated
#
# @author https://github.com/simp/pupmod-simp-simp/graphs/contributors
#
class simp::scenario::poss (
  Boolean $puppet_server_hosts_entry  = $::simp::puppet_server_hosts_entry
) inherits simp {

  assert_private()

  if $puppet_server_hosts_entry {
    if $server_facts and $server_facts['servername'] and $server_facts['serverip'] {
      $_pserver_alias = split($server_facts['servername'],'.')[0]

      host { $server_facts['servername']:
        ensure       => 'present',
        host_aliases => $_pserver_alias,
        ip           => $server_facts['serverip']
      }
    }
  }
}
