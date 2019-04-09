namespace :categories do
  desc "TODO"
  task index: :environment do
    Category.select{ |c| c.categories.size == 0 }.each do |category|
      category.check
    end
  end

end
