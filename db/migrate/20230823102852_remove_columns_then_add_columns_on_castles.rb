class RemoveColumnsThenAddColumnsOnCastles < ActiveRecord::Migration[7.0]
  def change
    remove_column :castles, :lat
    remove_column :castles, :lng
    add_column :castles, :latitude, :float
    add_column :castles, :longitude, :float
  end
end
