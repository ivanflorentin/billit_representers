require 'roar/representer/json'
require 'roar_generic_pagination_representer/representers/pagination_representer'

module Billit
  module BillCollectionPageRepresenter
    include Roar::Representer::JSON
    include PaginationRepresenter

    collection :items, :extend => BillRepresenter, :class => Bill

    property :current_page
    property :total_pages

    def page_url(*args)
      url_for(args.reduce(args[0]) {|hash, elems| hash.merge(elems)})
  	end
  end
end