class Addcolumnstocastles < ActiveRecord::Migration[7.0]
  def change
    add_column :castles, :lat, :float
    add_column :castles, :lng, :float
  end
end
