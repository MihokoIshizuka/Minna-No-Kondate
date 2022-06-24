class MenuComment < ApplicationRecord
  belongs_to :member, optional: true
  belongs_to :admin, optional: true
  belongs_to :menu
  has_many :notifications, dependent: :destroy
end
