require 'roar/representer'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/feature/client'
require 'roar/representer/json'
require 'roar/representer/json/hal'
# require 'roar/rails/hal'
require 'active_model'
require 'billit_representers/representers/paperwork_representer'
require 'billit_representers/representers/priority_representer'
require 'billit_representers/representers/report_representer'
require 'billit_representers/representers/document_representer'
require 'billit_representers/representers/directive_representer'
require 'billit_representers/representers/remark_representer'
require 'billit_representers/representers/revision_representer'
require 'billit_representers/models/paperwork'
require 'billit_representers/models/priority'
require 'billit_representers/models/report'
require 'billit_representers/models/document'
require 'billit_representers/models/directive'
require 'billit_representers/models/remark'
require 'billit_representers/models/revision'

module Billit
  module BillModelRepresenter
    include Roar::Representer::JSON::HAL
    # include Roar::Rails::HAL
    # include Roar::Representer::JSON

    module Initializer
      def initialize
        extend Billit::BillModelRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, ActiveModel::Validations
      klass.send :include, Roar::Representer::Feature::HttpVerbs
      klass.validates_presence_of :uid
      klass.validates :subject_areas, inclusion: { in: @@subject_areas_valid_values }
      klass.validates :stage, inclusion: { in: @@stage_valid_values }
      klass.validates :initial_chamber, inclusion: { in: @@initial_chamber_valid_values }
      klass.validates :current_priority, inclusion: { in: @@current_priority_valid_values }
    end

    property :uid
    property :title
    property :creation_date
    property :source
    property :initial_chamber
    property :current_priority
    property :stage
    property :sub_stage
    property :status
    property :resulting_document
    property :law_link
    property :merged_bills
    property :subject_areas
    property :authors
    property :publish_date
    property :abstract
    property :tags
    property :bill_draft_link

    collection :paperworks, extend: Billit::PaperworkRepresenter, class: Billit::Paperwork
    collection :priorities, extend: Billit::PriorityRepresenter, class: Billit::Priority
    collection :reports, extend: Billit::ReportRepresenter, class: Billit::Report
    collection :documents, extend: Billit::DocumentRepresenter, class: Billit::Document
    collection :directives, extend: Billit::DirectiveRepresenter, class: Billit::Directive
    collection :remarks, extend: Billit::RemarkRepresenter, class: Billit::Remark
    collection :revisions, extend: Billit::RevisionRepresenter, class: Billit::Revision

    link :self do
      bill_url(self.uid)
    end

    @@subject_areas_valid_values =
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

    @@initial_chamber_valid_values =
      [
        'C.Diputados',
        'Senado'
      ]

    @@current_priority_valid_values =
      [
        'Discusión inmediata',
        'Simple',
        'Sin urgencia',
        'Suma'
      ]
  end
end