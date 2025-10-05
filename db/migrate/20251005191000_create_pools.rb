class CreatePools < ActiveRecord::Migration[8.0]
  def change
    create_table :pools do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.integer :length_value, null: false
      t.string :length_unit, null: false
      t.integer :total_lanes, null: false
      t.boolean :verified, default: false
      t.boolean :indoor, default: false
      t.boolean :outdoor, default: false
      t.boolean :has_photos, default: false
      t.boolean :open_stall_showers, default: false
      t.boolean :private_showers, default: false
      t.boolean :day_lockers, default: false
      t.boolean :byol_lockers, default: false
      t.string :membership_type
      t.boolean :day_pass_available, default: false
      t.decimal :price_per_hour, precision: 8, scale: 2
      t.boolean :lifeguard_on_duty, default: false
      t.boolean :pull_buoy_available, default: false
      t.boolean :kickboard_available, default: false
      t.boolean :fins_available, default: false
      t.boolean :has_coaches, default: false
      t.boolean :accessible, default: false
      t.boolean :masters_swimming, default: false
      t.boolean :parking_available, default: false
      t.boolean :paid_parking, default: false
      t.text :description

      t.timestamps
    end
    
    add_index :pools, :city
    add_index :pools, [:latitude, :longitude]
  end
end
