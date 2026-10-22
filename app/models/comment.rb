class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  belongs_to :parent_comment,
             class_name: "Comment",
             optional: true,
             inverse_of: :replies
  has_many :replies,
           class_name: "Comment",
           foreign_key: "parent_comment_id",
           inverse_of: :parent_comment,
           dependent: :destroy

  validates :body, presence: true
  validate :parent_comment_belongs_to_same_post

  private

  def parent_comment_belongs_to_same_post
    return unless parent_comment && post_id != parent_comment.post_id

    errors.add(:parent_comment, "must belong to the same post")
  end
end
