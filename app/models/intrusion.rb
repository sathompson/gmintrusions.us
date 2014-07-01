class Intrusion < ActiveRecord::Base
  searchkick
  has_and_belongs_to_many :tags
end
