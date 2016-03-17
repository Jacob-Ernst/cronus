class Goal < ActiveRecord::Base
# Goal Fields:
# - string     :title, null: false
# - text       :description
# - integer    :frequency
# - datetime   :deadline
# - integer    :category
# - decimal    :target
# - references :user, index: true

  # Validation
  validates_presence_of  :title
  validates_inclusion_of :frequency, in: ["daily", "weekly", "monthly"]
  validates_inclusion_of :category, in: ["binary", "hourly", "tally"]
  validates_presence_of  :target

  enum category: [
     :binary,
     :hourly,
     :tally ]

  enum frequency: [
     :daily,
     :weekly,
     :monthly ]

  # Associations
  belongs_to :user
  has_and_belongs_to_many :tags

end
