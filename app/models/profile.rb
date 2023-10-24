class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  validates :name, presence: true

  has_one_attached :avatar do |attachable|
    attachable.variant(resize_to_limit: [100,100])
  end
end
