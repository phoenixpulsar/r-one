class CreateAvailabilitySlots < ActiveRecord::Migration[8.0]
  def change
    create_table :availability_slots do |t|
      t.references :pool, null: false, foreign_key: true
      t.date :slot_date, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.integer :available_lanes, null: false, default: 0

      t.timestamps
    end
    
    add_index :availability_slots, [:pool_id, :slot_date, :start_time]
  end
end
