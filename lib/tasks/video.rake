namespace :video do
  desc 'TODO'

  task convert: :environment do
    ConvertVideoJob.perform_later Kit.find(379)
    ConvertVideoJob.perform_later Kit.find(381)
  end
end
