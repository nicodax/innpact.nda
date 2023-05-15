# frozen_string_literal: true

class InstitutionEsgGenderEqualityPolicy < SettingPolicy
  def create?
    admin_or_general_manager || im_group_member?
  end

  private

  def im_group_member?
    @im_group_member ||= record.institution && record.institution.im_group.user_ids.include?(user.id)
  end
end
