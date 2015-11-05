class CreateTodosTable < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.integer :card_id
      t.string :content
      t.boolean :done, {default: false}

      t.timestamps null: false
    end
  end
end
