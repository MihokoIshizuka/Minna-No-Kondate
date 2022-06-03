class Menu < ApplicationRecord
  has_one_attached :menu_image



  def get_menu_image
    (menu_image.attached?) ? menu_image : 'no_image.jpg'
  end
end
