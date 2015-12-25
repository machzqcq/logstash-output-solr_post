Gem::Specification.new do |s|

  s.name            = 'logstash-output-solr_post'
  s.version         = '0.1'
  s.licenses        = ['MIT']
  s.email           = ['pradeep@seleniumframework.com']
  s.licenses        = ['MIT']
  s.summary         = "This output lets you index&store your logs in Solr."
  s.description     = "This gem is a logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/plugin install gemname. This gem is not a stand-alone program"
  s.authors         = ["Pradeep K. Macharla","Venkatesh R. Peruvemba"]
  s.homepage        = "https://github.com/machzqcq/logstash-output-solr_post.git"
  s.require_paths = ["lib"]

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "output" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core", ">= 2.0.0.beta2", "< 3.0.0"

  s.add_runtime_dependency 'stud'
  s.add_runtime_dependency 'uuidtools'

  s.add_development_dependency 'logstash-devutils'
end

