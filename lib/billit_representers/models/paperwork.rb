require 'billit_representers/representers/paperwork_representer'
module Billit
  class Paperwork
    include Billit::PaperworkRepresenter
  end

  def document
  	links[:document].href if links[:document].href
  end
end