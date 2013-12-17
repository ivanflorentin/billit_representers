require 'roar'
require 'roar/representer'
require 'roar/representer/feature/hypermedia'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/feature/client'
require 'active_model'
require 'roar/representer/json/hal'

module Billit
  module EventRepresenter
    # include Roar::Representer
    include Roar::Representer::JSON::HAL

    module Initializer
      def initialize
        extend Billit::EventRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end

    property :chamber
    property :created_at
    property :date
    property :description
    property :session
    property :stage
    property :updated_at

  end
end