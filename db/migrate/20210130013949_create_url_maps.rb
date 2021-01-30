class CreateUrlMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :url_maps do |t|
      t.string :url
      t.string :token
      t.timestamps
    end
  end
end
