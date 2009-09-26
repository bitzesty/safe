# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{safe}
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Ford"]
  s.date = %q{2009-09-26}
  s.description = %q{Storing encrypted data in a Rails app using Strongbox}
  s.email = %q{info@bitzesty.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "app/controllers/safe_cabinets_controller.rb",
     "app/models/safe_cabinet.rb",
     "app/views/safe_cabinets/show.html.erb",
     "config/safe_routes.rb",
     "init.rb",
     "install.rb",
     "lib/safe.rb",
     "lib/safe/extensions/routes.rb",
     "lib/safe/keys.rb",
     "rails/init.rb",
     "safe.gemspec",
     "tasks/safe_tasks.rake",
     "test/safe_test.rb",
     "test/test_helper.rb",
     "uninstall.rb"
  ]
  s.homepage = %q{http://github.com/bitzesty/safe}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{strongbox wrapper}
  s.test_files = [
    "test/safe_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
