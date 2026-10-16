class UserPolicy < ApplicationPolicy
  def index?
    user.present? && user.admin?
  end

  def show?
    user.present? && (user.admin? || record == user)
  end

  def update?
    user.present? && (user.admin? || record == user)
  end

  def destroy?
    user.present? && user.admin?
  end

  def edit_roles?
    user.present? && user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user&.admin?
        scope.all
      else
        scope.where(id: user&.id)
      end
    end
  end
end
