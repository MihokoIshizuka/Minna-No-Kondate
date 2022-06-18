class Tag < ApplicationRecord
  has_many :group_tags
  has_many :groups, through: :group_tags, dependent: :destroy
  has_many :menu_tags
  has_many :menus, through: :menu_tags
  has_many :members, dependent: :destroy
  has_many :member_tags
  has_many :members, through: :member_tags

  validates :name, presence: true

  def self.search_menu_on_tags(tag_id, time_zone)
    if tag_id.present?
      self.find(tag_id).menus.where(time_zone: time_zone).order(created_at: :desc)
    else
      Menu.where(time_zone: time_zone).order(created_at: :desc)
    end
  end
  
  def self.search_menu_on_tags_myself(member_id, tag_id, time_zone)
    if tag_id.present?
      self.find(tag_id).menus.where(time_zone: time_zone, member_id: member_id).order(created_at: :desc)
    else
      Menu.where(time_zone: time_zone, member_id: member_id).order(created_at: :desc)
    end
  end
end
