class Tag < ApplicationRecord
  has_many :group_tags
  has_many :groups, through: :group_tags, dependent: :destroy
  has_many :menu_tags
  has_many :menus, through: :menu_tags
  has_many :members, dependent: :destroy

  validates :name, presence: true
end
