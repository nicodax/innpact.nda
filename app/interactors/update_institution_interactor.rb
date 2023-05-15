# frozen_string_literal: true

class UpdateInstitutionInteractor
  include Interactor
  def call
    Institution.transaction do
      update_institution_object
    end
  end

  delegate :institution_params, :institution, :file, to: :context

  private

  def update_institution_object
    if !context.institution.update(institution_params)
      context.fail!(error: context.institution.errors.full_messages)
    end
  end
end
