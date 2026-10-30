class DashboardPolicy < ApplicationPolicy
  def show?
    user.present? && user.admin?
  end
end
