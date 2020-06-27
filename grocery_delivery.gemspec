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

Gem::Specification.new do |s|
  s.name = 'grocery_delivery'
  s.version = '0.0.9'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Grocery Delivery'
  s.description = 'Utility for keeping Chef servers in sync with a repo'
  s.authors = ['Phil Dibowitz', 'Marcin Sawicki']
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.files = %w{README.md LICENSE} + Dir.glob('lib/grocery_delivery/*.rb') +
            Dir.glob('bin/*')
  s.executables = 'grocery-delivery'
  s.license = 'Apache'
  s.add_dependency 'between_meals', '>= 0.0.11'
  s.add_dependency 'mixlib-config'
  [
    # tests spin up a chef-zero instance
    'chef-zero',
    # and the tests need knife
    'chef-dk',
    # to work around https://github.com/chef/chef/issues/7383
    'openssl',
  ].each do |dep|
    s.add_development_dependency dep
  end
  %w{
    rspec-core
    rspec-expectations
    rspec-mocks
    simplecov
  }.each do |dep|
    s.add_development_dependency dep
  end
  s.add_development_dependency 'rubocop', '= 0.55.0'
end
