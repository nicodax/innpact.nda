# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  def subject_metadata
    env = Rails.env
    env.production? ? '' : "[#{env}]"
  end
end
