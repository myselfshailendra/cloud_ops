class CreateRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :regions do |t|
      t.string :location
      t.string :location_type
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
