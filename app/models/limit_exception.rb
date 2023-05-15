# frozen_string_literal: true

class LimitException < ApplicationRecord
  acts_as_paranoid

  belongs_to :fund

  validates_presence_of :model, :model_id, :value
  validates :model_id, uniqueness: { scope: :model, scope: :fund_id }
  validate :model_instance_exists
  validates :description, length: { maximum: 100 }, presence: true
  # TODO [07/09/2020] [AFR] - add foreign key to Limit Exceptions (Countries, institutions, institution_groups) instead of using model

  def display_name
    "#{model.upcase} - #{associated_record_name}"
  end

  def associated_record_name
    case model
    when "institution"
      name = fund.institutions.with_deleted.find(self.model_id).name
    when "institution_group"
      name = fund.institution_groups.with_deleted.find(self.model_id).name
    when "country"
      name = fund.countries.with_deleted.find(self.model_id).name
    else
      raise "Invalid model"
    end

    return name
  end

  def model_instance_exists
    model.classify.constantize.where(id: model_id).any?
  end
end
