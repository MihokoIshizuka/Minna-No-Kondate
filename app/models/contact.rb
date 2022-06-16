class Contact < ApplicationRecord
  belongs_to :member, optional: true
  belongs_to :admin, optional: true

  validates :message, presence: true

  mount_uploader :image, ImageUploader
end
