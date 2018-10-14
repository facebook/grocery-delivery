Gem::Specification.new do |s|
  s.name = 'grocery_delivery'
  s.version = '0.0.8'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Grocery Delivery'
  s.description = 'Utility for keeping Chef servers in sync with a repo'
  s.authors = ['Phil Dibowitz', 'Marcin Sawicki']
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.files = %w{README.md LICENSE} + Dir.glob('lib/grocery_delivery/*.rb') +
            Dir.glob('bin/*')
  s.executables = 'grocery-delivery'
  s.license = 'Apache'
  s.add_dependency 'between_meals', '>= 0.0.6'
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
  s.add_development_dependency 'rubocop', '= 0.49.1'
end
