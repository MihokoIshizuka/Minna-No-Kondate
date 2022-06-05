class Menu < ApplicationRecord
  has_one_attached :menu_image

  belongs_to :member


  validates :date, presence: true
  validates :body, presence: true
  validates :menu_image, presence: true


  def get_menu_image(width, height)
    (menu_image.attached?) ? menu_image : 'no_image.jpg'
    menu_image.variant(resize_to_limit:[width,height]).processed
  end
end
