class AddCardGroupIdToCard < ActiveRecord::Migration
  def change
    add_column :cards, :card_group_id, :integer
  end
end
