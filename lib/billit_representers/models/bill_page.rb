require 'billit_representers/representers/bill_model_collection_page_representer'
module Billit
  class BillCollectionPage
    include Billit::BillModelCollectionPageRepresenter

    def self
	  links[:self].href if links[:self].href
	end

	def next
	  links[:next].href if links[:next]
	end

	def previous
	  links[:previous].href if links[:previous]
	end
  end
end