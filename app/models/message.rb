class Message < ApplicationRecord
  belongs_to :messageable, polymorphic: true

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 100 }
  validates :phone, length: { maximum: 20 }
  validates :content, presence: true
end
