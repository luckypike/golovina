class AddSlideinfoToSlide < ActiveRecord::Migration[5.1]
  def change
    add_column :slides, :link_name, :string
    add_column :slides, :weight, :integer
  end
end
