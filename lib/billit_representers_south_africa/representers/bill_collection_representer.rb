require 'roar/representer/json'
require 'billit_representers_south_africa/representers/bill_representer'


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
