require 'roar/representer/json'
require 'billit_representers/representers/paperwork_representer'

module Billit
  module PaperworkCollectionRepresenter
    # include Roar::Representer
    include Roar::Representer::JSON
    include Roar::Representer::Feature::Hypermedia
   
    collection :paperworks, :extend => PaperworkRepresenter, :class => Paperwork

    def paperworks
      collect
    end
  end
end