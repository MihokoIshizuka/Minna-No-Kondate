class Member < ApplicationRecord
  has_one_attached :profile_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :menus, dependent: :destroy
  has_many :menu_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :group_members
  has_many :groups, through: :group_members, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :member_tags
  has_many :tags, through: :member_tags, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length:{minimum:2, maximum:10}
  validates :introduction, presence: true, length:{maximum:20}
  validates :is_deleted, inclusion: { in: [true, false] }

# 退会したユーザーは同じアカウントでログインできない
  def active_for_authentication?
    super && (is_deleted == false)
  end
# ゲストユーザーの設定
  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'ゲスト', introduction: 'ゲストユーザー') do |member|
      member.password = SecureRandom.urlsafe_base64
    end
  end
# フォロー・フォロワーの設定
  def follow(member_id)
    relationships.create(followed_id: member_id)
  end

  def unfollow(member_id)
    relationships.find_by(followed_id: member_id).destroy
  end

  def following?(member)
    followings.include?(member)
  end


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # 検索
  def self.looks(word)
    @member = Member.where("name LIKE?", "%#{word}%")
  end
end
