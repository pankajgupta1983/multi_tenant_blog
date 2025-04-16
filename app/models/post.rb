class Post < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  scope :published, -> { where.not(published_at: nil) }
  validates :title, :body, presence: true
end

