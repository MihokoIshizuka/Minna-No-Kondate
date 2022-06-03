class Member < ApplicationRecord
  has_one_attached :profile_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
