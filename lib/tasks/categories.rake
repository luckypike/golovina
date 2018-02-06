namespace :categories do
  desc "TODO"
  task index: :environment do
    Category.find_each do |category|
      category.check_empty
    end
  end

end
