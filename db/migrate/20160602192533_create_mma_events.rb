class CreateMmaEvents < ActiveRecord::Migration
  def change
    create_table :mma_events do |t|
      t.string :organization
      t.string :name
      t.string :date
      t.string :location
      t.url :event_link

      t.timestamps null: false
    end
  end
end
