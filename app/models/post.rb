class Post < ApplicationRecord
    belongs_to :user
    has_many :attachments, as: :attachable
    
    has_many :comments, dependent: :destroy

    has_many :likes, as: :likeable

    validates :title, presence: true, uniqueness: true, length: { maximum: 8 }, format: { with: /\A[a-zA-Z]+\z/ }

    validates :description, presence: true
end