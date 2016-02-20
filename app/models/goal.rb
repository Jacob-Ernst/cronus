class Goal < ActiveRecord::Base

  enum category: [
     :binary,
     :hourly,
     :tally ]

  enum frequency: [
     :daily,
     :weekly,
     :monthly ]

  belongs_to :user
  has_and_belongs_to_many :tags

end
