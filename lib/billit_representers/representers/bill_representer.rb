require 'roar/representer/json/hal'
require 'roar/representer/feature/hypermedia'

module Billit
  module BillRepresenter
    include Roar::Representer::JSON::HAL

    property :uid
    property :title
    property :creation_date
    property :initiative
    property :origin_chamber
    property :current_urgency
    property :stage
    property :sub_stage
    property :state
    property :law
    property :link_law
    property :merged
    property :matters
    property :authors
    property :publish_date
    property :summary
    property :tags

    property :events
    property :urgencies
    property :reports
    property :modifications
    property :documents
    property :instructions
    property :observations

    link :self do
      bill_url(self.uid)
    end
  end
end