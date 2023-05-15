# frozen_string_literal: true

class InstitutionSubentityPolicy < ApplicationPolicy
  def edit?
    admin_or_investment_manager?
  end

  def update?
    admin_or_investment_manager?
  end

  def update_profile?
    admin_or_investment_manager?
  end

  def update_rating?
    admin_or_investment_manager?
  end

  def update_specific_breakdowns?
    admin_or_investment_manager?
  end

  def update_alinus_result?
    admin_or_investment_manager?
  end

  def update_gender_equality?
    admin_or_investment_manager?
  end

  def update_services_offered?
    admin_or_investment_manager?
  end

  def update_impact_indicator?
    admin_or_investment_manager?
  end

  def update_safeguard?
    admin_or_investment_manager?
  end

  def update_risk?
    admin_or_investment_manager?
  end

  def update_pai_indicator?
    admin_or_investment_manager?
  end

  def update_environment_pai?
    admin_or_investment_manager?
  end

  def delete_environment_pai?
    admin_or_investment_manager?
  end

  def update_social_pai?
    admin_or_investment_manager?
  end

  def delete_social_pai?
    admin_or_investment_manager?
  end

  private

  def admin_or_investment_manager?
    admin_or_general_manager || im_group_member?
  end

  def im_group_member?
    @im_group_member ||= record && record.im_group.user_ids.include?(user.id)
  end
end
