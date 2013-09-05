require 'roar/representer/json'
require 'billit_representers_south_africa/representers/bill_representer'

module Billit
  module BillCollectionPageRepresenter
    include Roar::Representer::JSON
    include Roar::Representer::Feature::Hypermedia
   
    collection :bills, :extend => BillRepresenter, :class => Bill

    property :total_entries
    property :current_page
    property :total_pages
   
    link :self do |params|
      url_for(params.merge(:page => current_page))
    end
   
    link :next do |params|
      url_for(params.merge(:page => next_page)) \
        if next_page
    end
   
    link :previous do |params|
      url_for(params.merge(:page => previous_page)) \
        if previous_page
    end
   
    def bills
      self
    end
  end
end