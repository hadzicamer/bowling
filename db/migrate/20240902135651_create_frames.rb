class CreateFrames < ActiveRecord::Migration[7.1]
  def change
    create_table :frames do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :number
      t.boolean :complete, default: false
      t.timestamps
    end
  end
end
