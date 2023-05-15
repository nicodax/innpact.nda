# frozen_string_literal: true

class InstitutionProvisionPolicy < InstitutionPolicy
  def validate?
    admin_or_general_manager && record.version_status == InstitutionProvision::VERSION_STATUS_TEMPORARY
  end
end
