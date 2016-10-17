class Favorite < ApplicationRecord
  default_scope { order(created_at: :desc) }

  scope :properties, -> do
    where(favoritable_type: :Property)
  end

  scope :markets, -> do
    where(favoritable_type: :Market)
  end

  belongs_to :favoritable, polymorphic: true
  belongs_to :user

  def favorite
    favorite_object = Favorite.where(
      user:             self.user_id,
      favoritable_id:   self.favoritable_id,
      favoritable_type: self.favoritable_type
    ).first

    if favorite_object
      favorite_object.destroy
    else
      self.save
    end
  end

  def self.is_favorited?(user, favoritable_id, favoritable_type)
    Favorite.exists?(
      user:             user,
      favoritable_id:   favoritable_id,
      favoritable_type: favoritable_type
    )
  end
end
