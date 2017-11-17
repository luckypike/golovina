namespace :themes do
  desc "TODO"
  task qwe: :environment do
    Theme.update_all(weight: 0)
  end

end
