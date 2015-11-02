class CreateMemos < ActiveRecord::Migration
  def change
    create_table :memos do |t|
      t.integer :card_id
      t.string :content

      t.timestamps null: false
    end
  end
end
