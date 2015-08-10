lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kubernetes-topology-graph/version'

Gem::Specification.new do |s|
  s.name             = 'kubernetes-topology-graph'
  s.version          = KubernetesTopologyGraph::VERSION
  s.license          = 'LGPL-2.1'
  s.summary          = 'Kubernetes Topology Graph'
  s.description      = 'Provides a simple force directed topology graph of kubernetes items.'
  s.authors          = 'Dávid Halász'
  s.email            = 'dhalasz@redhat.com'
  s.homepage         = 'https://github.com/kubernetes-ui/topology-graph'

  s.required_ruby_version = '>= 2.0.0'

  # TODO: update those manually
  s.add_runtime_dependency 'angularjs-rails', '>=1.3.8', '<1.5'
  s.add_runtime_dependency 'rails-assets-d3', '>=3.5.0', '<=3.5.5'

  s.add_development_dependency 'rake', '~> 10.4'

  s.files = Dir.glob('{lib,assets}/**/*') + %w(README.md Rakefile)
end
