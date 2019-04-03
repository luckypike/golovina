class AddStoreToAvailabilities < ActiveRecord::Migration[5.2]
  def change
    add_reference :availabilities, :store
  end
end
