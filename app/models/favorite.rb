class Favorite < ApplicationRecord
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
