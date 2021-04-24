class Analysis < ApplicationRecord
  validates_presence_of :resource, :category
end
