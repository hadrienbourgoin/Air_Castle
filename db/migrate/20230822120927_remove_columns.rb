class RemoveColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column  :castles, :photo
  end
end
