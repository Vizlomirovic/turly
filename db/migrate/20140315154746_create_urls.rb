class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url
      t.text :shorten, :limit => 6

      t.timestamps
    end
  end
end
