class Contact < ApplicationRecord
  belongs_to :member
  belongs_to :admin

  validates :message, presence: true

  mount_uploader :image, ImageUploader
end
