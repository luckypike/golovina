namespace :users do
  desc "TODO"
  task clear_phone: :environment do
    User.find_each do |user|
      user.save if user.phone.present?
    end
  end

end
