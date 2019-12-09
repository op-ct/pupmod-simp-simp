# @summary *(Deprecated)* This class will be removed in a future version of SIMP
#
# @deprecated This class will be removed in a future version of SIMP
#
class simp::base_services {

  simplib::module_metadata::assert($module_name, { 'blacklist' => ['Windows'] })

  # to ensure api compatbility
  include 'simp::base_apps'

}
