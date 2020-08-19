class AddVideoHideToVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :video_hide, :boolean, default: false
  end
end
