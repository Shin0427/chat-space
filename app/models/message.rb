class Message < ApplicationRecord

  belongs_to :group
  belongs_to :user
  
  validates :content, presence: true, unless: :image?
  # validates: image, presence: true, unless: :body?

  mount_uploader :image, ImageUploader
  
end
