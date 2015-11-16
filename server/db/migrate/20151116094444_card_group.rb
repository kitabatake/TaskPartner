class CardGroup < ActiveRecord::Migration
  def change
    create_table :card_groups do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
