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
  validate :parent_comment_within_nesting_limit

  MAX_NESTING_LEVEL = 3

  def nesting_level
    parent_comment ? parent_comment.nesting_level + 1 : 1
  end

  private

  def parent_comment_belongs_to_same_post
    return unless parent_comment && post_id != parent_comment.post_id

    errors.add(:parent_comment, "must belong to the same post")
  end

  def parent_comment_within_nesting_limit
    return unless parent_comment
    return if parent_comment.nesting_level < MAX_NESTING_LEVEL

    errors.add(:parent_comment, "cannot be nested beyond level #{MAX_NESTING_LEVEL}")
  end
end
