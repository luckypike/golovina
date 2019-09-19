require 'csv'

namespace :delivery_cities do
  desc 'Default cities'
  task :seed, [:seed] => :environment do |_task, args|
    seed = args.seed.presence || 'config/delivery_cities.csv'

    CSV.foreach(seed, col_sep: ';') do |row|
      city = DeliveryCity.where(title: row[0].strip).first_or_initialize
      city.door = row[1]
      city.door_days = row[2]
      city.storage = row[3]
      city.storage_days = row[4]
      city.save
    end
  end
end
