class PostPolicy < ApplicationPolicy
  def manage?
    user.present? && user.admin?
  end

  def index?
    true
  end

  def show?
    return false unless record

    record.published? || user&.admin? || record.user == user
  end

  def create?
    user.present? && (user.admin? || user.author?)
  end

  def update?
    return false unless user.present?

    user.admin? || record.user == user
  end

  def destroy?
    user.present? && (user.admin? || record.user == user)
  end

  def toggle_published?
    update?
  end

  class Scope < ApplicationPolicy::Scope
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
