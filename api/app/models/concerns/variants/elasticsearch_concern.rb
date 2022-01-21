# frozen_string_literal: true

module Variants
  module ElasticsearchConcern
    extend ActiveSupport::Concern

    included do
      include Elasticsearch::Model

      settings do
        mappings dynamic: false do
          indexes :title, fields: {
            ru: { analyzer: :russian, type: :text },
            en: { analyzer: :english, type: :text }
          }

          indexes :color, type: 'object' do
            indexes :title, fields: {
              ru: { analyzer: :russian, type: :text },
              en: { analyzer: :english, type: :text }
            }
          end

          # indexes :sizes, type: 'object' do
          #   indexes :size, analyzer: :english, type: :text
          # end
        end
      end
    end
  end
end
