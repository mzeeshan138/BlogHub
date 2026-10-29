class User < ApplicationRecord
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
  has_one_attached :avatar

  validate :avatar_must_be_an_image

  enum :role, { admin: "admin", author: "author", user: "user" }, default: :user, validate: true

  validates :name, presence: true
  validates :role, presence: true

  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role ||= "user"
  end

  def avatar_must_be_an_image
    return unless avatar.attached?

    unless %w[image/png image/jpeg image/gif].include?(avatar.content_type)
      errors.add(:avatar, "must be a PNG, JPEG, or GIF image")
    end

    errors.add(:avatar, "must be smaller than 5 MB") if avatar.byte_size > 5.megabytes
  end
end
