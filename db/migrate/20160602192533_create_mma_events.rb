class CreateMmaEvents < ActiveRecord::Migration
  def change
    create_table :mma_events do |t|
      t.string :organization
      t.string :name
      t.string :date_string
      t.date :date
      t.string :location
      t.string :event_url

      t.timestamps null: false
    end
  end
end
