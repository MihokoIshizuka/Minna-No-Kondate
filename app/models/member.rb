class Member < ApplicationRecord
  has_one_attached :profile_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :menus, dependent: :destroy
  has_many :menu_comments, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length:{minimum:2, maximum:15}
  validates :introduction, presence: true, length:{maximum:50}
  validates :is_deleted, inclusion: { in: [true, false] }


  def active_for_authentication?
    super && (is_deleted == false)
  end


  def get_profile_image(width, height)
    (profile_image.attached?) ? profile_image.variant(resize_to_limit:[width,height]).processed : 'cat.png'
  end
end
