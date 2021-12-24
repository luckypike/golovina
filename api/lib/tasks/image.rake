namespace :image do
  desc "Recreate thumbs"
  task recreate: :environment do
    Image.all.each { |i| i.photo.recreate_versions! }
  end
end
