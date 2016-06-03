class CreateFights < ActiveRecord::Migration
  def change
    create_table :fights do |t|
      t.integer :match
      t.references :event, null: false
      t.belongs_to :fighter_a, null: false
      t.belongs_to :fighter_b, null: false
      t.string :fighter_a_result
      t.string :fighter_b_result
      t.string :win_method
      t.string :referee
      t.integer :round
      t.string :time
      t.timestamps null: false
    end

  end
end
