class Fight < ActiveRecord::Base
  belongs_to :fighter_a, class_name: "Fighter", foreign_key: "fighter_a_id"
  belongs_to :fighter_b, class_name: "Fighter", foreign_key: "fighter_b_id"
  belongs_to :event


  validates :match, presence: true
  validates :event_id, presence: true
  validates :fighter_a_id, presence: true
  validates :fighter_b_id, presence: true
  validates :fighter_a_result, presence: true
  validates :fighter_b_result, presence: true
  validates :win_method, presence: true
end
