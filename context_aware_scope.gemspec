# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{context_aware_scope}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Simplificator", "Fabio Kuhn"]
  s.date = %q{2010-08-27}
  s.description = %q{Allows to add a context to a named_scope that will be passed through the whole scope chain}
  s.email = %q{info@simplificator.com}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    ".gitignore",
     "README.textile",
     "Rakefile",
     "VERSION",
     "context_aware_scope.gemspec",
     "lib/context_aware_scope.rb",
     "test/database.yml",
     "test/models.rb",
     "test/test_helper.rb",
     "test/units/default_scope_test.rb",
     "test/units/lambda_scope_test.rb",
     "test/units/normal_scope_test.rb",
     "test/units/readme_sample_test.rb"
  ]
  s.homepage = %q{http://github.com/simplificator/context_aware_scope}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Add context to named_scopes in ActiveRecord}
  s.test_files = [
    "test/models.rb",
     "test/test_helper.rb",
     "test/units/default_scope_test.rb",
     "test/units/lambda_scope_test.rb",
     "test/units/normal_scope_test.rb",
     "test/units/readme_sample_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 2.11"])
      s.add_development_dependency(%q<leftright>, [">= 0"])
      s.add_runtime_dependency(%q<activerecord>, [">= 2.0.0"])
    else
      s.add_dependency(%q<shoulda>, [">= 2.11"])
      s.add_dependency(%q<leftright>, [">= 0"])
      s.add_dependency(%q<activerecord>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 2.11"])
    s.add_dependency(%q<leftright>, [">= 0"])
    s.add_dependency(%q<activerecord>, [">= 2.0.0"])
  end
end

