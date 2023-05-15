class AddVersionStatusForInstitutionProvision < ActiveRecord::Migration[6.0]
  def change
    add_column :institution_provisions, :version_status, :string,
               default: InstitutionProvision::VERSION_STATUS_TEMPORARY, null: false
  end
end
