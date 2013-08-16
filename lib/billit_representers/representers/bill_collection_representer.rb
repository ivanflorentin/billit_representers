require 'roar/representer/json'
require 'billit_representers/representers/bill_representer'


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
