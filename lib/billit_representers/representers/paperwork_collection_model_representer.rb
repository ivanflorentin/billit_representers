require 'roar/representer/json'
require 'billit_representers/representers/paperwork_representer'
require 'billit_representers/models/paperwork'

module Billit
  module PaperworkCollectionModelRepresenter
    # include Roar::Representer
    include Roar::Representer::JSON
    include Roar::Representer::Feature::Hypermedia

    module Initializer
      def initialize
        extend Billit::PaperworkCollectionModelRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end
   
    collection :paperworks, :extend => Billit::PaperworkRepresenter, :class => Billit::Paperwork

    def paperworks
      collect
    end
  end
end