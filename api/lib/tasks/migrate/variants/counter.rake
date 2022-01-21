# frozen_string_literal: true

namespace :migrate do
  namespace :variants do
    desc 'Reindex variants'
    task counter: :environment do
      Api::Variant.find_each do |variant|
        VariantProcessJob.perform_later(variant: variant)
      end
    end
  end
end
