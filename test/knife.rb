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

log_level :info
log_location STDOUT
node_name 'gd'
client_key 'gd.pem'
validation_client_name 'chef-validator'
validation_key 'chef-validator.pem'
chef_server_url 'http://127.0.0.1:8889'
cookbook_path [
  '/tmp/master_path/target/chef/cookbooks/',
]
