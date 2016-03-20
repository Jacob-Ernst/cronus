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

  accepts_nested_attributes_for :tags

  def add_tags(tags)
    tags.each do |tag|
      tag_for_adding = Tag.where(name: tag).first_or_create do |t|
        t.attributes = {name: tag} if t.name == nil
      end

      self.tags << tag_for_adding unless self.tags.include? tag_for_adding
    end
  end

  def remove_tags(tags)
    tags.each do |tag|
      tag_for_removing = User.tags.where(name: tag)

      self.tags.delete(tag_for_removing) << tag_for_removing unless tag_for_removing.empty?
    end
  end

end
