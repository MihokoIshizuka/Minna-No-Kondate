class Menu < ApplicationRecord
  has_one_attached :menu_image

  belongs_to :member




  def get_menu_image
    (menu_image.attached?) ? menu_image : 'no_image.jpg'
  end
end
