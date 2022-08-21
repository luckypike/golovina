# frozen_string_literal: true

module Colors
  class IndexCmd < ApplicationCmd
    output :colors

    def call
      self.colors = Api::Color.includes(:colors).where(parent_color_id: nil).order(title_ru: :asc)
      # self.colors = Api::Color.dataset.eager(:colors).where(Sequel[:colors][:parent_color_id] => nil)
      #   .order(Sequel.asc(:title_ru))
      #   .all
    end
  end
end
