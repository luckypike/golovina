class AddUniqIndexToAvailabilities < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        Act.where.not(store_id: 1).each do |act|
          availability = Availability.find_by(
            variant: act.availability.variant,
            store_id: 1
          )

          act.update(availability: availability) if availability
        end

        Availability.where.not(store_id: 1).each do |availability|
          availability.delete if availability.acts.empty?
        end

        execute <<-SQL
          DELETE FROM availabilities
          WHERE quantity IS NULL
        SQL
      end
    end

    add_index :availabilities, %i[variant_id size_id], unique: true
  end
end
