namespace :products do
  desc "TODO"
  task index: :environment do
    Product.all.each do |product|
      product.sync_variants
      product.check_empty
    end
  end

end
