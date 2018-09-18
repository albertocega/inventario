class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.decimal :amount
      t.references :ingredient, index: true, foreign_key: true
      t.references :recipe, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
