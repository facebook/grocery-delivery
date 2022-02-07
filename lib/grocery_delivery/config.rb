# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2

# Copyright 2013-present Facebook
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'mixlib/config'
require 'logger'

module GroceryDelivery
  # Config file parser and config object
  # Uses Mixlib::Config v1 syntax so it works in Chef10 omnibus...
  # it's compatible with v2, so it should work in 11 too.
  class Config
    extend Mixlib::Config
    berks false
    berks_bin '/opt/chefdk/bin/berks'
    berks_config nil
    config_file '/etc/gd-config.rb'
    cookbook_paths ['chef/cookbooks']
    databag_path 'chef/databags'
    dry_run false
    lockfile '/var/lock/subsys/grocery_delivery'
    master_path '/var/chef/grocery_delivery_work'
    knife_bin '/opt/chef/bin/knife'
    knife_config '/root/.chef/knife.rb'
    pidfile '/var/run/grocery_delivery.pid'
    plugin_path '/etc/gd-plugin.rb'
    repo_update true
    repo_url nil
    reponame 'ops'
    role_path 'chef/roles'
    role_type 'rb'
    stdout false
    track_symlinks false
    rev_checkpoint 'gd_revision'
    vcs_path nil
    vcs_type 'svn'
    verbosity Logger::WARN
  end
end
