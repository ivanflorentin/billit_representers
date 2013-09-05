require 'roar/representer/json/hal'
require 'roar/representer/feature/client'

module Billit
  module BillRepresenter
    include Roar::Representer::JSON::HAL

    module Initializer
      def initialize
        extend Billit::BillRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end

    property :id
    property :title
    property :tags
    property :bill_version
    property :effective_date
    property :document_attachment

    link :self do
      bill_url(self.id)
    end
  end
end