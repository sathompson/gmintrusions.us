class Tag < ActiveRecord::Base
  searchkick
  validates :name, uniqueness: { case_sensitive: false,
    message: 'Tag already exists.' },
    presence: { message: 'Tag must have a name.' }
  has_and_belongs_to_many :intrusions
end
