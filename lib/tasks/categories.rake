namespace :categories do
  desc "TODO"
  task index: :environment do
    Category.find_each do |category|
      if category.id == 40
        category.check_empty
        p category.empty
      end
    end
  end

end
