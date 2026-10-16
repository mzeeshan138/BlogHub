class CommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    return false unless user.present?

    user.admin? || record.user == user
  end
end
