class Chat < ApplicationRecord
  belongs_to :member, optional: true
  belongs_to :admin, optional: true
  belongs_to :group


  validates :message, presence: true

  mount_uploader :image, ImageUploader

end
