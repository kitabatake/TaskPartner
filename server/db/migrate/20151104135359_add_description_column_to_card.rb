class AddDescriptionColumnToCard < ActiveRecord::Migration
  def change
    add_column :cards, :description, :string
  end
end
