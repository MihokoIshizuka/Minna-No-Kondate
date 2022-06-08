class MenuTag < ApplicationRecord
  belongs_to :tag
  belongs_to :menu
end
