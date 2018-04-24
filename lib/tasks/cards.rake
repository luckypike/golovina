namespace :cards do
  task index: :environment do
    # doc = File.open(Rails.application.secrets[:trudvsem_xml])
    if File.exist?(Rails.application.secrets[:cards_csv])
      # puts File.exist?(Rails.application.secrets[:cards_csv])
      require 'csv'

      csv_text = File.read(Rails.application.secrets[:cards_csv])
      csv = CSV.parse(csv_text, :encoding => 'ISO-8859-1')
      csv.first(3).each do |row|

        user = User.find_by(phone: row[2].gsub(/[^0-9]/, ''))
        discount = Discount.where(id: row[0]).first_or_create
        discount.user = user
        discount.phone = row[2].gsub(/[^0-9]/, '')
        discount.name = row[1]
        discount.size = 5
        # theme.title = v['title']
        # theme.title_long = v['title_long']
        # theme.desc = v['desc']
        # theme.weight = v['weight']
        # theme.state = v['state']
        # discount.save
        p discount
        p row
        p row[2].gsub(/[^0-9]/, '') if !row[2].blank?
      end
    end
  end
end
