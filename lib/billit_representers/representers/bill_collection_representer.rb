require 'roar/representer/json'

module Billit
  module BillCollectionRepresenter
    include Roar::Representer::JSON
    include Roar::Representer::Feature::Hypermedia

    collection :bills, :extend => BillRepresenter, :class => Bill

    def bills
      collect
    end
  end
end
