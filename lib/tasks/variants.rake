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
end
