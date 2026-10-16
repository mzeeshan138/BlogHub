class PostsPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? && (user.admin? || user.author?)
  end

  def update?
    return false unless user.present?

    user.admin? || record.user == user
  end

  def destroy?
    return false unless user.present?

    user.admin? || record.user == user
  end

  def toggle_published?
    update?
  end

  class Scope < Scope
    def resolve
      if user&.admin?
        scope.all
      elsif user&.author?
        scope.where(user: user)
      else
        scope.where(published: true)
      end
    end
  end
end
