class Post < ApplicationRecord
    belongs_to :user
    has_many :attachments, as: :attachable
    
    has_many :comments, dependent: :destroy

    has_many :likes, as: :likeable
end
