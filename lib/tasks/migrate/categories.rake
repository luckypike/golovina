namespace :categories do
  desc "Remove nested categories"
  task flatten: :environment do
    Category.includes(:parent_category).where.not(parent_category_id: nil).each do |category|
      new_category_id =
        if category.parent_category.parent_category_id
          category.parent_category.parent_category_id
        else
          category.parent_category_id
        end

      category.products.each do |product|
        product.update_attribute(:category_id, new_category_id.to_s)
      end

      category.destroy
    end
  end
end
