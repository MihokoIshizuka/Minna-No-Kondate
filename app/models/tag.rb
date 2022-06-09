class Tag < ApplicationRecord
  has_many :group_tags
  has_many :groups, through: :group_tags, dependent: :destroy
  has_many :menu_tags
  has_many :menus, through: :menu_tags
  has_many :members, dependent: :destroy
  has_many :member_tags
  has_many :members, through: :member_tags

  validates :name, presence: true
end
