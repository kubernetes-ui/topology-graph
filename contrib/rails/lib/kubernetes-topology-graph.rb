require 'kubernetes-topology-graph/version'

module KubernetesTopologyGraph
  class << self
    def load!
      if rails?
        register_rails_engine
      elsif sprockets?
        register_sprockets
      end
    end

    # Paths
    def gem_path
      @gem_path ||= File.expand_path '..', File.dirname(__FILE__)
    end

    def javascripts_path
      File.join assets_path, 'javascripts'
    end

    def stylesheets_path
      File.join assets_path, 'stylesheets'
    end

    def assets_path
      @assets_path ||= File.join gem_path, 'assets'
    end

    # Environment detection helpers
    def sprockets?
      defined?(::Sprockets)
    end

    def rails?
      defined?(::Rails)
    end

    def register_rails_engine
      require 'kubernetes-topology-graph/engine'
    end

    def register_sprockets
      Sprockets.append_path(javascripts_path)
      Sprockets.append_path(stylesheets_path)
    end
  end
end

KubernetesTopologyGraph.load!
