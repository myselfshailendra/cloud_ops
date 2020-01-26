class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :offer_term_code
      t.string :sku
      t.string :product_family
      t.string :description
      t.integer :begin_range
      t.integer :end_range
      t.string :unit
      t.string :price_per_unit
      t.datetime :effective_date
      t.string :usage_type
      t.references :region, null: false, foreign_key: true

      t.timestamps
    end
  end
end
