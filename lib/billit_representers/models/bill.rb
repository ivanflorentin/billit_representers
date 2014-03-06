require 'billit_representers/representers/bill_model_representer'
module Billit
  class Bill
    include Billit::BillModelRepresenter

    def self_link
	  links[:self].href if links[:self]
	end

	def law_xml_link
	  links[:law_xml].href if links[:law_xml]
	end

	def law_web_link
	  links[:law_web].href if links[:law_web]
	end

	def bill_draft_link
	  links[:bill_draft].href if links[:bill_draft]
	end
  end
end