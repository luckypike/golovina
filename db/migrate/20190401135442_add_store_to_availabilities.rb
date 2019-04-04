class AddStoreToAvailabilities < ActiveRecord::Migration[5.2]
  def change
    add_reference :availabilities, :store

    reversible do |dir|
      dir.up do
        Availability.in_batches.update_all(store_id: Store.first.id)
      end
    end
  end
end
