class CreateSismos < ActiveRecord::Migration[7.1]
  def change
    create_table :sismos do |t|
      t.string :external_id
      t.decimal :magnitude
      t.string :place
      t.string :time
      t.boolean :tsunami
      t.string :mag_type
      t.string :title
      t.decimal :longitude
      t.decimal :latitude
      t.string :url

      t.timestamps
    end
  end
end
