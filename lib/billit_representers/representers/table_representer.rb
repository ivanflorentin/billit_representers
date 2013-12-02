require 'roar/representer/json/hal'
require 'roar/representer/feature/hypermedia'
require 'active_model'

module Billit
  module TableRepresenter
    include Roar::Representer::JSON::HAL

    module Initializer
      def initialize
        extend Billit::TableRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end

    property :uid
    property :origin_chamber
    property :creation_date
    property :legislature
    property :session
    property :bills


    link :self do
      bill_url(self.uid)
    end
  end
end