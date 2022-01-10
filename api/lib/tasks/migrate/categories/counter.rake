# frozen_string_literal: true

namespace :migrate do
  namespace :categories do
    desc 'Reindex categories'
    task counter: :environment do
      Api::Category.find_each do |category|
        CategoryProcessJob.perform_later(category: category)
      end
    end
  end
end
