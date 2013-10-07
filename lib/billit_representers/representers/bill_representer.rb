require 'roar/representer/feature/hypermedia'
require 'active_model'

module Billit
  module BillRepresenter
    include Roar::Representer::JSON::HAL

    module Initializer
      def initialize
        extend Billit::BillRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, ActiveModel::Validations
      klass.send :include, Roar::Representer::Feature::HttpVerbs
      klass.validates_presence_of :uid
      klass.validates :matters, inclusion: { in: @@matters_valid_values }
      klass.validates :stage, inclusion: { in: @@stage_valid_values }
      klass.validates :origin_chamber, inclusion: { in: @@origin_chamber_valid_values }
      klass.validates :current_urgency, inclusion: { in: @@current_urgency_valid_values }
    end

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
    property :abstract
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

    @@matters_valid_values =
      [
        'Defensa',
        'Impuestos',
        'Economía',
        'Empresas',
        'Hacienda',
        'Relaciones Exteriores',
        'Administración',
        'Asunto Indígena',
        'Zona Extrema',
        'Regionalización',
        'Salud',
        'Minería',
        'Medio Ambiente',
        'Derechos Animales',
        'Vivienda',
        'Obras Públicas',
        'Transporte',
        'Telecomunicaciones',
        'Trabajo',
        'Protección Social',
        'Cultura',
        'Educación',
        'Deportes',
        'Transparencia',
        'Probidad',
        'Elecciones',
        'Participación',
        'Familia',
        'Seguridad',
        'Derechos Fundamentales',
        'Nacionalidad',
        'Reconstrucción Terremoto'
      ]

    @@stage_valid_values =
      [
        'Archivado',
        'Comisión Mixta Ley de Presupuesto',
        'Comisión Mixta por rechazo de idea de legislar',
        'Comisión Mixta por rechazo de modificaciones',
        'Disc. informe C.Mixta por rechazo de modific. en C...',
        'Discusión veto en Cámara de Origen',
        'Discusión veto en Cámara Revisora',
        'Insistencia',
        'Primer trámite constitucional',
        'Retirado',
        'Segundo trámite constitucional',
        'Tercer trámite constitucional',
        'Tramitación terminada',
        'Trámite de aprobacion presidencial',
        'Trámite finalización en Cámara de Origen'
      ]

    @@origin_chamber_valid_values =
      [
        'C.Diputados',
        'Senado'
      ]

    @@current_urgency_valid_values =
      [
        'Discusión inmediata',
        'Simple',
        'Sin urgencia',
        'Suma'
      ]
  end
end