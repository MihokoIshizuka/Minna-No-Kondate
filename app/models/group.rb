class Group < ApplicationRecord
  has_one_attached :image
  has_many :group_members
  has_many :members, through: :group_members, dependent: :destroy
  has_many :group_tags
  has_many :tags, through: :group_tags, dependent: :destroy
  has_many :chats, dependent: :destroy


  validates :name, presence: true, length:{minimum:2, maximum:15}
  validates :introduction, presence: true, length:{maximum:30}
  validates :tag_ids, presence: true

  def get_image
    (image.attached?) ? image : 'group_image.png'
  end
end
