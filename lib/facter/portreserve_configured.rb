# portreserve_configured
#
# Returns whether or not the /etc/portreserve directory is empty
#
# @return [Boolean] True if /etc/portreserve has content, false otherwise
#
#   * Is confined on the presence of this directory.
#
# @author https://github.com/simp/pupmod-simp-simp/graphs/contributors
#
Facter.add('portreserve_configured') do
  confine do
    File.directory?('/etc/portreserve')
  end

  has_weight 1

  setcode do
    !Dir.glob('/etc/portreserve/*').empty?
  end
end
