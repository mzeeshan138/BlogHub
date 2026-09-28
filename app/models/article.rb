class Article < ApplicationRecord
  belongs_to :user

  has_many :article_comments

  has_many :commenters,
           through: :article_comments,
           source: :user

  has_many :likes, as: :likeable
  has_many :attachments, as: :attachable
end
