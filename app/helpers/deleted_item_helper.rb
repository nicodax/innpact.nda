module DeletedItemHelper
  def display_deleted_record(record)
    return record.model if record.class == DefaultLimit
    return record.display_name if record.class == LimitException
    return " #{record.get_parent_of_document.name} - #{record.original_filename}" if [PoolDocument,
                                                                                      PoolLegalDocument].include?(record.class)
    return "#{record.name} - #{record.rate}" if record.class == CurrencyRate
    return record.short_name if record.class == Currency

    return record.institution.name if record.class == InstitutionCovenant

    return record.name
    # end
  end
end
