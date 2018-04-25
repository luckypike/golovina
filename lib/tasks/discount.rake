namespace :discount do
  task index: :environment do
    # doc = File.open(Rails.application.secrets[:trudvsem_xml])
    if File.exist?(Rails.application.secrets[:cards_csv])
      # puts File.exist?(Rails.application.secrets[:cards_csv])
      require 'csv'

      csv_text = File.read(Rails.application.secrets[:cards_csv])
      csv = CSV.parse(csv_text, :encoding => 'ISO-8859-1')
      csv.each do |row|

        if !row[2].nil? && !row[2].gsub(/[^0-9]/, '').blank?
          user = User.find_by(phone: row[2].gsub(/[^0-9]/, ''))
          discount = Discount.where(id: row[0]).first_or_create
          discount.user = user
          discount.phone = row[2].gsub(/[^0-9]/, '')
          discount.name = row[1]
          discount.size = 0.05
          discount.size = 0.1 if row[0].to_i > 99
          discount.size = 0.2 if row[0].to_i > 199
          discount.save
          p row[2].gsub(/[^0-9]/, '').blank?
        end
      end
    end
  end
end
