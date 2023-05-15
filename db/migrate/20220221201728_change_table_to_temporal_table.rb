class ChangeTableToTemporalTable < ActiveRecord::Migration[6.0]
  def change
    sql = ""


    # Temporal Data Countries
    source = File.new("#{Rails.root}/db/sql/temporalTableCountries.sql", "r")
    while (line = source.gets)
      sql << line
    end
    # Temporal Data Currencies
    source = File.new("#{Rails.root}/db/sql/temporalTableCurrencies.sql", "r")
    while (line = source.gets)
      sql << line
    end
    # Temporal Data Funds
    source = File.new("#{Rails.root}/db/sql/temporalTableFunds.sql", "r")
    while (line = source.gets)
      sql << line
    end
    # Temporal Data ImGroup
    source = File.new("#{Rails.root}/db/sql/temporalTableImGroup.sql", "r")
    while (line = source.gets)
      sql << line
    end
    # Temporal Data Institutions
    source = File.new("#{Rails.root}/db/sql/temporalTableInstitutions.sql", "r")
    while (line = source.gets)
      sql << line
    end
    # Temporal Data InterestRateTypes
    source = File.new("#{Rails.root}/db/sql/temporalTableInterestRateTypes.sql", "r")
    while (line = source.gets)
      sql << line
    end
    # Temporal Data Loans
    source = File.new("#{Rails.root}/db/sql/temporalTableLoans.sql", "r")
    while (line = source.gets)
      sql << line
    end
    # Temporal Data Pools
    source = File.new("#{Rails.root}/db/sql/temporalTablePools.sql", "r")
    while (line = source.gets)
      sql << line
    end
    # Temporal Data RepaymentCalendar
    source = File.new("#{Rails.root}/db/sql/temporalTableRepaymentCalendar.sql", "r")
    while (line = source.gets)
      sql << line
    end
    # Temporal Data Users
    source = File.new("#{Rails.root}/db/sql/temporalTableUsers.sql", "r")
    while (line = source.gets)
      sql << line
    end
    # Temporal Data Bonds
    source = File.new("#{Rails.root}/db/sql/temporalTableBonds.sql", "r")
    while (line = source.gets)
      sql << line
    end

    source.close

    execute <<-SQL
      CREATE SCHEMA History;
    SQL

    execute sql
  end
end
