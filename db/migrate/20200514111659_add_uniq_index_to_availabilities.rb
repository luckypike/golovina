class AddUniqIndexToAvailabilities < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          DELETE FROM availabilities
          WHERE quantity IS NULL
        SQL

        Act.where.not(store_id: 1).each do |act|
          availability = Availability.find_by(
            variant: act.availability.variant,
            size: act.availability.size,
            store_id: 1
          )

          act.update(availability: availability) if availability
        end

        Availability.where.not(store_id: 1).each do |availability|
          availability.delete if availability.acts.empty?
        end
      end
    end

    add_index :availabilities, %i[variant_id size_id], unique: true
  end
end
