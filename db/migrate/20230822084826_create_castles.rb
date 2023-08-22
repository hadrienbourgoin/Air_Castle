class CreateCastles < ActiveRecord::Migration[7.0]
  def change
    create_table :castles do |t|
      t.string :name
      t.integer :price
      t.text :address
      t.text :description
      t.text :photo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
