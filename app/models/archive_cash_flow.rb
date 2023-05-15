# frozen_string_literal: true

class ArchiveCashFlow < ApplicationRecord
  # A column name is defined as "type" in the DB which is not allowed by rails
  # Unless it is disabled as done here.
  # This column name could be change for good practice if it doesn't break the client reports.
  self.inheritance_column = :_type_disabled
end
