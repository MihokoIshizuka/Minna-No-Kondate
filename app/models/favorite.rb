class Favorite < ApplicationRecord
  belongs_to :member
  belongs_to :menu

  # def active_favorites
  #   favorites.joins(:member).where(member: {is_deleted: false})
  # end
end
