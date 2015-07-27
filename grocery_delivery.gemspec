Gem::Specification.new do |s|
  s.name = 'grocery_delivery'
  s.version = '0.0.5'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Grocery Delivery'
  s.description = 'Utility for keeping Chef servers in sync with a repo'
  s.authors = ['Phil Dibowitz', 'Marcin Sawicki']
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.files = %w{README.md LICENSE} + Dir.glob('lib/grocery_delivery/*.rb') +
    Dir.glob('bin/*')
  s.executables = 'grocery-delivery'
  s.license = 'Apache'
  %w{
    mixlib-config
    between_meals
  }.each do |dep|
    s.add_dependency dep
  end
  %w{
    rubocop
  }.each do |dep|
    s.add_development_dependency dep
  end
end
