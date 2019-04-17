namespace :variants do
  desc "TODO"
  task sizes: :environment do
    sizes_group = {}

    sizes = Size.all

    SizesGroup.find_each do |sg|
      sizes_group[sg.id] = sizes.select{|s| s.sizes_group_id == sg.id}.map{|s| [s.id, s.size]}
    end

    Variant.includes(:product).find_each do |variant|
      if variant.sizes.is_a? Array
        if variant.product.category.get_ancestor == Rails.application.secrets[:men]
          sizes = sizes_group[2]
        elsif variant.product.category.get_ancestor == Rails.application.secrets[:shoes]
          sizes = sizes_group[3]
        else
          sizes = sizes_group[1]
        end

        v_sizes = variant.sizes.reject(&:blank?)
        #
        new_sizes = {}
        sizes.each do |id, size|
          new_sizes[id] = 0
          new_sizes[id] = 1 if v_sizes.include?(size)
        end

        variant.sizes = new_sizes.as_json
        variant.save
      end
    end

    OrderItem.includes(:variant).find_each do |item|
      if item.variant.product.category.get_ancestor == Rails.application.secrets[:men]
        sizes = sizes_group[2]
      elsif item.variant.product.category.get_ancestor == Rails.application.secrets[:shoes]
        sizes = sizes_group[3]
      else
        sizes = sizes_group[1]
      end

      sizes.each do |id, size|
        item.size = id if item.size == size.to_i
      end

      item.save
    end
  end

  task save: :environment do
    Variant.all.each do |variant|
      variant.save
    end
  end

  task update: :environment do
    Variant.all.each do |variant|

      variant.desc = variant.product.desc if !variant.desc.present? && variant.product.desc
      variant.comp = variant.product.comp if !variant.comp.present? && variant.product.comp
      variant.price = variant.product.price if !variant.price.present? && variant.product.price
      variant.price_last = variant.product.price_last if !variant.price_last.present? && variant.product.price_last

      variant.save
    end
  end

  task updated_at: :environment do
    Variant.all.each do |variant|
      if variant.images.present?
        variant.update_attribute(:updated_at, variant.images.last.updated_at)
      end
    end
  end

  task images: :environment do
    Variant.where(state: :archived).each do |variant|
      if (Time.now - variant.updated_at) / 86400 > 59
        variant.images.each do |image|
          image.destroy
        end
      end
    end
  end
end
