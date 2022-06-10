class Menu < ApplicationRecord
  has_one_attached :menu_image

  belongs_to :member
  has_many :menu_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :menu_tags
  has_many :tags, through: :menu_tags, dependent: :destroy



  validates :date, presence: true
  validates :body, presence: true
  validates :menu_image, presence: true
  validates :tag_ids, presence: true



  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
  
  # 検索
  def self.looks(word)
    @menu = Menu.where("body LIKE?", "%#{word}%")
  end
end
