class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy

    has_many :articles
    has_many :article_comments
    has_many :commented_articles, through: :article_comments, source: :article

    has_many :user_groups
    has_many :groups, through: :user_groups

    has_many :attachments, as: :attachable

    validates :name, presence: true
end
