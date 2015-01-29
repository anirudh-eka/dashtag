# == Define: git::config
#
# Used to configure git
#
# === Parameters
#
# [*value*]
#   The config value. Example: Mike Color or john.doe@example.com.
#   See examples below.
#
# [*section*]
#   The configuration section. Example: user.
#   By default extracted from the resource name.
#
# [*key*]
#   The configuration key. Example: email.
#   By default extracted from the resource name.
#
# [*user*]
#   The user for which the config will be set. Default value: root
#
# [*scope*]
#   The scope of the configuration, can be system or global.
#   Default value: global
#
# === Examples
#
# Provide some examples on how to use this type:
#
#   git::config { 'user.name':
#     value => 'John Doe',
#   }
#
#   git::config { 'user.email':
#     value => 'john.doe@example.com',
#   }
#
#   git::config { 'user.name':
#     value   => 'Mike Color',
#     user    => 'vagrant',
#     require => Class['git'],
#   }
#
#  git::config { 'http.sslCAInfo':
#     value   => $companyCAroot,
#     user    => 'root',
#     scope   => 'system',
#     require => Company::Certificate['companyCAroot'],
#   }
#
# === Authors
#
# === Copyright
#
define git::config (
  $value,
  $section  = regsubst($name, '^([^\.]+)\.([^\.]+)$','\1'),
  $key      = regsubst($name, '^([^\.]+)\.([^\.]+)$','\2'),
  $user     = 'root',
  $scope    = 'global',
) {
  git_config { $title:
    section => $section,
    key     => $key,
    value   => $value,
    user    => $user,
    scope   => $scope,
  }
}
