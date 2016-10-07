class PropertyTag < ApplicationRecord
  belongs_to :property
  belongs_to :tag

  validates :property, presence: true
  validates :tag, presence: true
  validates :tag, uniqueness: { scope: :property }
end
