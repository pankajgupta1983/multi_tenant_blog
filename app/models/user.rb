class User < ApplicationRecord
  belongs_to :organization
  has_many :posts, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatables
end
