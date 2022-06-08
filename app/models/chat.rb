class Chat < ApplicationRecord
  belongs_to :member
  belongs_to :group

  validates :message, presence: true

  mount_uploader :image, ImageUploader

end
