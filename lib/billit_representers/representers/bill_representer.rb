# coding: utf-8
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
require 'billit_representers/representers/motion_representer'
require 'billit_representers/models/paperwork'
require 'billit_representers/models/priority'
require 'billit_representers/models/report'
require 'billit_representers/models/document'
require 'billit_representers/models/directive'
require 'billit_representers/models/remark'
require 'billit_representers/models/revision'
require 'billit_representers/models/motion'

module Billit
  module BillRepresenter
    include Roar::Representer::JSON::HAL
    # include Roar::Rails::HAL
    # include Roar::Representer::JSON

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
      klass.validates :subject_areas, inclusion: { in: @@subject_areas_valid_values }
      klass.validates :stage, inclusion: { in: @@stage_valid_values }
      klass.validates :initial_chamber, inclusion: { in: @@initial_chamber_valid_values }
      klass.validates :current_priority, inclusion: { in: @@current_priority_valid_values }
    end

    property :uid
    property :short_uid
    property :title
    property :creation_date
    property :source
    property :initial_chamber
    property :current_priority
    property :stage
    property :sub_stage
    property :status
    property :resulting_document
    property :law_id
    property :bill_draft_link
    property :merged_bills
    property :subject_areas
    property :authors
    property :publish_date
    property :abstract
    property :tags

    collection :paperworks, extend: Billit::PaperworkRepresenter, class: lambda { |x, *| Object.const_defined?("Paperwork") ? Paperwork : BillitPaperwork }
    collection :priorities, extend: Billit::PriorityRepresenter, class: lambda { |x, *| Object.const_defined?("Priority") ? Priority : BillitPriority }
    collection :reports, extend: Billit::ReportRepresenter, class: lambda { |x, *| Object.const_defined?("Report") ? Report : BillitReport }
    collection :documents, extend: Billit::DocumentRepresenter, class: lambda { |x, *| Object.const_defined?("Document") ? Document : BillitDocument }
    collection :directives, extend: Billit::DirectiveRepresenter, class: lambda { |x, *| Object.const_defined?("Directive") ? Directive : BillitDirective }
    collection :remarks, extend: Billit::RemarkRepresenter, class: lambda { |x, *| Object.const_defined?("Remark") ? Remark : BillitRemark }
    collection :revisions, extend: Billit::RevisionRepresenter, class: lambda { |x, *| Object.const_defined?("Revision") ? Revision : BillitRevision }
    collection :motions, extend: Billit::MotionRepresenter, class: lambda { |x, *| Object.const_defined?("Motion") ? Motion : BillitMotion }

    link :self do
      bill_url(self.uid)
    end

    link :law_xml do 
        self.law_xml_link
    end

    link :law_web do 
        self.law_web_link
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
        'Ingreso de Respuesta a Pedido de Informe ',
        'Resolución Unicameral Aprobado ',
        'Se comunica a quien corresponda ',
        'Dictamen de comision ',
        'Discusion plenario ',
        'Resolucion de archivo ',
        'Resolución que Aprueba Declaración ',
        'Proyecto Retirado ',
        'Resolucion que Aprueba Pedido de Informe ',
        'Resolucion rechazo modificaciones a Camara Revisora ',
        'Media sancion ',
        'Dictamen de Comision - (3T) - Rechazo ',
        'Archivado ',
        'Archivado y no se puede repetir en las sesiones del año ',
        'Resolucion de Sancion segun Camara Revisora ',
        'Resolucion Sancion Completa ',
        'Dictamen de Comision - (4T)- Ratifica ',
        'Discusion Plenario (3T) - Modificaciones ',
        'En Espera de Publicación ',
        'Entrada de Respuesta a Pedido de Informe ',
        'ParteRechaza Objeción Parcial en CO) ',
        'ParteRechaza ',
        'Parte Rechaza ',
        'Discusion Plenario (Aprobado Objeción Parcial - Sanciona Parte No Objetada en CO) ',
        'Dictamen de Comision (Aprobado Objeción Parcial - Sanciona Parte No Objetada en CO) ',
        'Dictamen de Comision - (4T) - Rechazo ',
        'Discusion Plenario (Aprobacion Objeción en CO) ',
        'Discusion Plenario (3T) - Rechazo ',
        'Mensaje de modificaciones a Camara de Origen ',
        ' Trámite de Espera Veto',
        'Dictamen de Comision (3T) - Modificaciones '
      ]

    @@initial_chamber_valid_values =
      [
        'C. Diputados',
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
