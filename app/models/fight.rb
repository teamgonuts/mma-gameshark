class Fight < ActiveRecord::Base
  belongs_to :fighter_a, class_name: "Fighter", foreign_key: "fighter_a_id"
  belongs_to :fighter_b, class_name: "Fighter", foreign_key: "fighter_b_id"
end
