class AddVideoHideToKits < ActiveRecord::Migration[6.0]
  def change
    add_column :kits, :video_hide, :boolean, default: false
  end
end
