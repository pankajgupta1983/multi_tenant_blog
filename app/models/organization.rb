class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :posts, dependent: :destroy
  
  validates :name, :subdomain, presence: true
  validates :subdomain, uniqueness: true
end

