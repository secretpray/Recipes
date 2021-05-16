class RecipePolicy < ApplicationPolicy
  
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user
  end

  def create?
    user
  end

  def edit
    user && user.id == record.user_id || user&.admin? || user&.moderator?
  end

  def update?
    user && user.id == record.user_id || user&.admin? || user&.moderator?
  end

  def destroy?
    user && user.id == record.user_id || user&.admin? || user&.moderator?
  end

  def review?
    return false if Review.find_by(user: user, recipe_id: record.id).present?
    user && user&.id != record.user_id || user&.admin?  || user&.moderator?
  end
end
