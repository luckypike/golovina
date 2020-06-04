namespace :variants do
  desc 'TODO'

  task recalc: :environment do
    Availability.includes(:acts).find_each do |availability|
      availability.update(quantity: availability.acts.sum(&:quantity))
    end

    Variant.includes(:availabilities, :acts).find_each do |variant|
      variant.update(
        quantity: variant.availabilities.sum(&:quantity),
        acts_count: variant.acts.size
      )
    end
  end

  task updated_at: :environment do
    Variant.all.each do |variant|
      if variant.images.present?
        variant.update_attribute(:updated_at, variant.images.last.updated_at)
      end
    end
  end

  # task images: :environment do
  #   Variant.where(state: :archived).each do |variant|
  #     if (Time.now - variant.updated_at) / 86400 > 59
  #       variant.images.each do |image|
  #         image.destroy
  #       end
  #     end
  #   end
  # end
end
