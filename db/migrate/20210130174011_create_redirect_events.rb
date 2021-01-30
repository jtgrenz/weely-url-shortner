class CreateRedirectEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :redirect_events do |t|
      t.references :url_map
      t.string :ip_address
      t.timestamps
    end

    add_reference :url_maps, :redirect_events, foreign_key: true
  end
end
