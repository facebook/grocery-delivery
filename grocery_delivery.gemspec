Gem::Specification.new do |s|
  s.name = 'grocery_delivery'
  s.version = '0.0.7'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Grocery Delivery'
  s.description = 'Utility for keeping Chef servers in sync with a repo'
  s.authors = ['Phil Dibowitz', 'Marcin Sawicki']
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.files = %w{README.md LICENSE} + Dir.glob('lib/grocery_delivery/*.rb') +
    Dir.glob('bin/*')
  s.executables = 'grocery-delivery'
  s.license = 'Apache'
  s.add_dependency 'mixlib-config'
  s.add_dependency 'between_meals', '>= 0.0.6'
  %w{
    rubocop
    knife-solo
    chef-zero
  }.each do |dep|
    s.add_development_dependency dep
  end
end
