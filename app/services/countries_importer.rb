# frozen_string_literal: true

class CountriesImporter < SpreadsheetFileImporter
  FILE_HEADER = ['High Income Country', 'Country Name', 'GDP', 'GDP per capita',
                 'Mimosa Score', 'ISO Code', 'Population', 'Rating', 'GNI'].freeze

  def self.import_file(file, current_user, fund)
    service = new(file)
    service.process(current_user, fund)
  end

  def initialize(file)
    @file = file
  end

  def process(current_user, fund)
    spreadsheet = open_spreadsheet(file)
    raise EmptyImportFile if check_for_empty_file(spreadsheet)

    header = spreadsheet.sheet('Country Data').row(1)
    raise InvalidFileHeader unless valid_header?(file_header)

    (2..spreadsheet.sheet('Country Data').last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      begin
        country = fund.countries.with_deleted.find_by(iso_code: row['ISO Code'].strip)
        if row['High Income Country'].strip == 'No'
          high_income_country = false
        elsif row['High Income Country'].strip == 'Yes'
          high_income_country = true
        else
          raise "can't process -" + row["High Income Country"] + "- Yes/No expected "
        end
        if country.nil?
          fund.countries.create(name: row['Country Name'].strip,
                                iso_code: ISO3166::Country.find_country_by_alpha2(row['ISO Code'].strip).alpha2,
                                population: row['Population'],
                                rating: row['Rating'],
                                gdp: row['GDP'],
                                gdp_per_capita: row['GDP per capita'],
                                gni: row['GNI'],
                                gni_per_capita: row['GNI per capita'],
                                mimosa_score: row['Mimosa Score'],
                                is_a_high_income_country: high_income_country,
                                created_by: current_user.full_name)
        elsif country.deleted?
          raise DeletedCountryError.new "Cannot create : " + row["Country Name"] + "It is present in the recycle bin"
        else
          country.update(
            # name: row["Country Name"].strip, The client requested that the name would not be updated via FileUpload
            # iso_code: ISO3166::Country.find_country_by_alpha2(row["ISO Code"].strip).alpha2,
            population: row['Population'],
            rating: row['Rating'],
            gdp: row['GDP'],
            gdp_per_capita: row['GDP per capita'],
            gni: row['GNI'],
            gni_per_capita: row['GNI per capita'],
            mimosa_score: row['Mimosa Score'],
            is_a_high_income_country: high_income_country,
            created_by: current_user.full_name
          )
        end
      rescue DeletedCountryError => e
        raise e.message
      rescue => e
        if e.message.include? "alpha2"
          raise "The Iso Code (alpha2) for : " + row["Country Name"].strip + "; at line " + i.to_s + " does not match any official ISO 3166 Country Name "
        else
          raise " Error occured at line " + i.to_s + " " + e.message + " : " + I18n.t("settings.countries.upload.create_error")
        end
      end
    end
  end

  private

  def file_header
    FILE_HEADER
  end
end

class DeletedCountryError < StandardError
end
