class Intrusion < ActiveRecord::Base
  searchkick
  validates :description, uniqueness: { case_sensitive: false,
    message: 'Intrusion already exists.' },
    presence: { message: 'Intrusion must have a description.' }
  has_and_belongs_to_many :tags
end
