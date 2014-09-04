Gem::Specification.new do |s|
  s.name = 'grocery-delivery'
  s.version = '0.0.1'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Grocery Delivery'
  s.description = 'Utility for keeping Chef servers in sync with a repo'
  s.authors = ['Phil Dibowitz', 'Marcin Sawicki']
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.files = %w{README.md LICENSE} + Dir.glob("lib/grocery-delivery/*.rb") +
    Dir.glob("bin/*")
  s.executables = 'grocery-delivery'
  s.license = 'Apache'
  %w{
    mixlib-config
    between-meals
  }.each do |dep|
    s.add_dependency dep
  end
end
