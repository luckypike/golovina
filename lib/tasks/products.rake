namespace :products do
  desc "TODO"
  task sync_variants: :environment do
    Product.all.each do |product|
      product.sync_variants
    end
  end

end
