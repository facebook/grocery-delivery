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

lockfile '/tmp/grocery_delivery'
pidfile '/tmp/grocery_delivery.pid'
master_path '/tmp/master_path'
vcs_type 'git'
reponame 'target'
repo_url 'file:///tmp/source'
knife_bin 'bundle exec knife'
knife_config './test/knife.rb'
