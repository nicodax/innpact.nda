# frozen_string_literal: true

class InstitutionProfile < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution

  validates :as_of, presence: true

  # yes / no / not yet but committed

  def self.use_of_standard_reporting_tools_map
    {
      'yes' => 'Yes',
      'no' => 'No',
      'not yet but committed' => 'Not yet but commited'
    }
  end

  def self.use_of_standard_reporting_tools_options
    use_of_standard_reporting_tools_map.collect { |k, v| [v, k] }
  end

  def self.tier_map
    {
      1 => 'Tier I',
      2 => 'Tier II',
      3 => 'Tier III'
    }
  end

  def self.tier_options
    tier_map.collect { |k, v| [v, k] }
  end

  def self.cpps_adoption_map
    {
      'not compliant' => 'Not Compliant',
      'compliant_no_certification' => 'Compliant - No Certification',
      'certified' => 'Certified'
    }
  end

  def self.cpps_adoption_options
    cpps_adoption_map.collect { |k, v| [v, k] }
  end
end
