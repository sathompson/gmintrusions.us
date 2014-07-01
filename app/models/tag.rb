class Tag < ActiveRecord::Base
  searchkick
  has_and_belongs_to_many :intrusions
end
