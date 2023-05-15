#Local Variable instantiation
#Local path
_localpath = Dir.pwd
_csv_path = "/db/csv_files/"
_country_path = "TAB_COUNTRY.csv"
_country_CCY_path = "COUNTRY_CCY.csv"
_rating_path = "TAB_RATING_COUNTRY.csv"
_new_rating_path = "TAB_NEW_RATING.csv"
_region_path = "TAB_REGION.csv"
_currency_path = "TAB_CCY.csv"
_currency_rate_path = "TAB_FX_RATE.csv"
_institution_path = "TAB_MFI.csv"
_institution_group_path = "TAB_GROUP.csv"
_status_path = "TAB_STATUS.csv"
_position_path = "TAB_POSITION.csv"
_bond_path = "TAB_BOND.csv"
_interest_rate_type_path = "TAB_INTEREST_RATE_TYPE.csv"
_loan_type_path = "TAB_TYPEOFLOAN.csv"
_repayment_type_path = "TAB_REPAYMENT_TYPE.csv"
_pool_path = "TAB_POOL.csv"
_vrr_path = "TAB_VRR_LOAN.csv"
_vrr_type_path = "TAB_VRR_TYPE.csv"
_provision_path = "TAB_PROVISION.csv"
_calendar_path = "TAB_REPAYMENT_CALENDAR.csv"
_imGroup_path = "TAB_IM.csv"
_esticalhisto_path = "TABSOURCE_ESTICALHISTO.csv"

# hash linking countries with ISO name
country_to_iso = {
"Afghanistan"=>"AF",
"Aland_Islands"=>"AX",
"Albania"=>"AL",
"Algeria"=>"DZ",
"American_Samoa"=>"AS",
"Andorra"=>"AD",
"Angola"=>"AO",
"Anguilla"=>"AI",
"Antarctica"=>"AQ",
"Antigua_and_Barbuda"=>"AG",
"Argentina"=>"AR",
"Armenia"=>"AM",
"Aruba"=>"AW",
"Australia"=>"AU",
"Austria"=>"AT",
"Azerbaijan"=>"AZ",
"Bahamas"=>"BS",
"Bahamas,_The"=>"BS",
"Bahamas_The"=>"BS",
"Bahrain"=>"BH",
"Bangladesh"=>"BD",
"Barbados"=>"BB",
"Belarus"=>"BY",
"Belgium"=>"BE",
"Belize"=>"BZ",
"Benin"=>"BJ",
"Bermuda"=>"BM",
"Bhutan"=>"BT",
"Bolivia"=>"BO",
"Bosnia_and_Herzegovina"=>"BA",
"Botswana"=>"BW",
"Bouvet_Island"=>"BV",
"Brazil"=>"BR",
"British_Indian_Ocean_Territory"=>"IO",
"Brunei_Darussalam"=>"BN",
"Bulgaria"=>"BG",
"Burkina_Faso"=>"BF",
"Burundi"=>"BI",
"Cabo_Verde"=>"CV",
"Cambodia"=>"KH",
"Cameroon"=>"CM",
"Canada"=>"CA",
"Cape_Verde"=>"CV",
"Cayman_Islands"=>"KY",
"Central_African_Republic"=>"CF",
"Chad"=>"TD",
"Channel_Islands"=>"CS",
"Chile"=>"CL",
"China"=>"CN",
"Christmas_Island"=>"CX",
"Cocos_(Keeling)_Islands"=>"CC",
"Colombia"=>"CO",
"Comoros"=>"KM",
"Congo"=>"CG",
"Congo,_Democratic_Republic"=>"CD",
"Congo_Republic"=>"CG",
"DRC"=>"CD",
"Cook_Islands"=>"CK",
"Costa_Rica"=>"CR",
"Cote_d'Ivoire"=>"CI",
"Croatia"=>"HR",
"Cuba"=>"CU",
"Curacao"=>"CW",
"Cyprus"=>"CY",
"Czech_Republic"=>"CZ",
"Denmark"=>"DK",
"Djibouti"=>"DJ",
"Dominica"=>"DM",
"Dominican_Republic"=>"DO",
"Ecuador"=>"EC",
"Egypt"=>"EG",
"El_Salvador"=>"SV",
"Equatorial_Guinea"=>"GQ",
"Eritrea"=>"ER",
"Estonia"=>"EE",
"Ethiopia"=>"ET",
"Eswatini"=>"SZ",
"Falkland_Islands_(Malvinas)"=>"FK",
"Falkland_Islands"=>"FK",
"Malvinas"=>"FK",
"Faroe_Islands"=>"FO",
"Fiji"=>"FJ",
"Finland"=>"FI",
"France"=>"FR",
"French_Guiana"=>"GF",
"French_Polynesia"=>"PF",
"French_Southern_Territories"=>"TF",
"Gabon"=>"GA",
"Gambia"=>"GM",
"Gambia,_The"=>"GM",
"Gambia_The"=>"GM",
"Georgia"=>"GE",
"Germany"=>"DE",
"Ghana"=>"GH",
"Gibraltar"=>"GI",
"Greece"=>"GR",
"Greenland"=>"GL",
"Grenada"=>"GD",
"Guadeloupe"=>"GP",
"Guam"=>"GU",
"Guatemala"=>"GT",
"Guernsey"=>"GG",
"Guinea"=>"GN",
"Guinea-Bissau"=>"GW",
"Guyana"=>"GY",
"Haiti"=>"HT",
"Heard_Island_&_Mcdonald_Islands"=>"HM",
"Holy_See_(Vatican_City_State)"=>"VA",
"Honduras"=>"HN",
"Hong_Kong"=>"HK",
"Hong_Kong_SAR,_China"=>"HC",
"Hong_Kong_SAR_China"=>"HC",
"Hungary"=>"HU",
"Iceland"=>"IS",
"India"=>"IN",
"Indonesia"=>"ID",
"Iran,_Islamic_Republic_Of"=>"IR",
"Iran,_Islamic_Rep."=>"IR",
"Iran_Islamic_Rep."=>"IR",
"Iraq"=>"IQ",
"Ireland"=>"IE",
"Isle_Of_Man"=>"IM",
"Isle_of_Man"=>"IM",
"Israel"=>"IL",
"Italy"=>"IT",
"Ivory_Coast"=>"CI",
"Jamaica"=>"JM",
"Japan"=>"JP",
"Jersey"=>"JE",
"Jordan"=>"JO",
"Kazakhstan"=>"KZ",
"Kenya"=>"KE",
"Kiribati"=>"KI",
"Korea,_Rep."=>"KR",
"Korea_Rep."=>"KR",
"North_Korea"=>"KP",
"Kuwait"=>"KW",
"Kyrgyzstan"=>"KG",
"Kyrgyz_Republic"=>"KG",
"Kosovo"=>"KO",
"Laos"=>"LA",
"Latvia"=>"LV",
"Lebanon"=>"LB",
"Lesotho"=>"LS",
"Liberia"=>"LR",
"Libyan_Arab_Jamahiriya"=>"LY",
"Libya"=>"LY",
"Liechtenstein"=>"LI",
"Lithuania"=>"LT",
"Luxembourg"=>"LU",
"Macao_SAR,_China"=>"MO",
"Macao_SAR_China"=>"MO",
"Macao"=>"MO",
"Macedonia"=>"MK",
"North_Macedonia"=>"MK",
"Madagascar"=>"MG",
"Malawi"=>"MW",
"Malaysia"=>"MY",
"Maldives"=>"MV",
"Mali"=>"ML",
"Malta"=>"MT",
"Marshall_Islands"=>"MH",
"Martinique"=>"MQ",
"Mauritania"=>"MR",
"Mauritius"=>"MU",
"Mayotte"=>"YT",
"Mexico"=>"MX",
"Micronesia,_Federated_States_Of"=>"FM",
"Micronesia,_Fed._Sts."=>"FM",
"Micronesia_Fed._Sts."=>"FM",
"Moldova"=>"MD",
"Monaco"=>"MC",
"Mongolia"=>"MN",
"Montenegro"=>"ME",
"Montserrat"=>"MS",
"Morocco"=>"MA",
"Mozambique"=>"MZ",
"Myanmar"=>"MM",
"Namibia"=>"NA",
"Nauru"=>"NR",
"Nepal"=>"NP",
"Netherlands"=>"NL",
"Netherlands_Antilles"=>"AN",
"New_Caledonia"=>"NC",
"New_Zealand"=>"NZ",
"Nicaragua"=>"NI",
"Niger"=>"NE",
"Nigeria"=>"NG",
"Niue"=>"NU",
"Norfolk_Island"=>"NF",
"Northern_Mariana_Islands"=>"MP",
"Norway"=>"NO",
"Oman"=>"OM",
"Pakistan"=>"PK",
"Palau"=>"PW",
"Palestine"=>"PS",
"Palestinian_Territory,_Occupied"=>"PS",
"Panama"=>"PA",
"Papua_New_Guinea"=>"PG",
"Paraguay"=>"PY",
"Peru"=>"PE",
"Philippines"=>"PH",
"Pitcairn"=>"PN",
"Poland"=>"PL",
"Portugal"=>"PT",
"Puerto_Rico"=>"PR",
"Qatar"=>"QA",
"Reunion"=>"RE",
"Romania"=>"RO",
"Russian_Federation"=>"RU",
"Russia"=>"RU",
"Rwanda"=>"RW",
"Saint_Barthelemy"=>"BL",
"Saint_Helena"=>"SH",
"Saint_Kitts_and_Nevis"=>"KN",
"St._Kitts_and_Nevis"=>"KN",
"Saint_Lucia"=>"LC",
"St._Lucia"=>"LC",
"Saint_Martin"=>"MF",
"Sint_Maarten_(Dutch_part)"=>"MF",
"Saint_Pierre_and_Miquelon"=>"PM",
"Saint_Vincent_and_Grenadines"=>"VC",
"St._Vincent_and_the_Grenadines"=>"VC",
"Samoa"=>"WS",
"San_Marino"=>"SM",
"Sao_Tome_and_Principe"=>"ST",
"Saudi_Arabia"=>"SA",
"Senegal"=>"SN",
"Serbia"=>"RS",
"Seychelles"=>"SC",
"Sierra_Leone"=>"SL",
"Singapore"=>"SG",
"Slovakia"=>"SK",
"Slovak_Republic"=>"SK",
"Slovenia"=>"SI",
"Solomon_Islands"=>"SB",
"Somalia"=>"SO",
"South_Africa"=>"ZA",
"South_Georgia_and_Sandwich_Isl."=>"GS",
"Spain"=>"ES",
"Sri_Lanka"=>"LK",
"Sudan"=>"SD",
"South_Sudan"=>"SS",
"Suriname"=>"SR",
"Svalbard_and_Jan_Mayen"=>"SJ",
"Swaziland"=>"SZ",
"Sweden"=>"SE",
"Switzerland"=>"CH",
"Syrian_Arab_Republic"=>"SY",
"Taiwan"=>"TW",
"Tajikistan"=>"TJ",
"Tanzania"=>"TZ",
"Thailand"=>"TH",
"Timor-Leste"=>"TL",
"Togo"=>"TG",
"Tokelau"=>"TK",
"Tonga"=>"TO",
"Trinidad_and_Tobago"=>"TT",
"Tunisia"=>"TN",
"Turkey"=>"TR",
"Turkmenistan"=>"TM",
"Turks_and_Caicos_Islands"=>"TC",
"Tuvalu"=>"TV",
"Uganda"=>"UG",
"Ukraine"=>"UA",
"UK"=>"UK",
"United_Arab_Emirates"=>"AE",
"United_Kingdom"=>"GB",
"United_States"=>"US",
"USA"=>"US",
"United_States_Outlying_Islands"=>"UM",
"Uruguay"=>"UY",
"Uzbekistan"=>"UZ",
"Vanuatu"=>"VU",
"Venezuela"=>"VE",
"Venezuela,_RB"=>"VE",
"Venezuela_RB"=>"VE",
"Vietnam"=>"VN",
"Virgin_Islands,_British"=>"VG",
"Virgin_Islands,_U.S."=>"VI",
"Wallis_and_Futuna"=>"WF",
"Western_Sahara"=>"EH",
"West_Bank_and_Gaza"=>"WG",
"Worldwide"=>"WO",
"Yemen"=>"YE",
"Yemen,_Rep."=>"YE",
"Yemen_Rep."=>"YE",
"Zambia"=>"ZM",
"Zimbabwe"=>"ZW"
}

#Function used for the migration
def is_numeric?(s)
  begin
    Float(s)
  rescue
    false # not numeric
  else
    true # numeric
  end
end

def map_status(map_status)
  #Map the old Access DB status with the new SQL database status
  case map_status
  when "assigned"
    return "assigned"
  when "appetite inquiry"
    return "appetite_inquiry"
  when "approval expired"
    return "approval_expired"
  when "approved change request"
    return "approved_change_request"
  when "approved"
    return "approved"
  when "assignement expired"
    return "assignement_expired"
  when "matured"
    return "matured"
  when "invested"
    return "invested"
  when "not approved"
    return "not_approved"
  when "not ratified"
    return "not_ratified" 
  when "not validated"
    return "not_validated" 
  when "pending approval"
    return "pending_approval"
  when "pending ratification"
    return "pending_ratification"
  when "ratified"
    return "ratified"
  when "released after approval"
    return "released_after_approval"
  when "released before approval"
    return "released_before_approval"
  else
    return "NO"
  end
end

def country_migration(fund, country_table, country_rating, country_new_rating, country_to_iso, admin)
  countries_array = []
  country_table.each do |row|
    if (country_to_iso[row["COUNTRY_NAME"].tr(" ", "_")].nil?)
      puts "The country #{row["COUNTRY_NAME"].tr(" ", "_")} is not present in the ISO_LIST"
    end
    newCountry = {
                    name: row["COUNTRY_NAME"][0...50],
                    iso_code: country_to_iso[row["COUNTRY_NAME"].tr(" ", "_")],
                    created_by: "#{admin.firstname} #{admin.lastname}"
                  }
    specific_country_rating = country_rating.select {|item| item["COUNTRY_NAME"] == row["COUNTRY_NAME"]}
    specific_country_new_rating = country_new_rating.select {|item| item["Country_Name"] == row["COUNTRY_NAME"]}
  
    if (specific_country_new_rating.length() == 0)
      puts("There is no NewRating value for the country #{row["COUNTRY_NAME"]}")
    else
      if (specific_country_new_rating.first["Rating_Moodys"].nil? == false)
        newCountry[:rating] = specific_country_new_rating.first["Rating_Moodys"]
      end
      if (is_numeric?(specific_country_new_rating.first["Rating_Mimosa"]) && specific_country_rating.first["Rating_Mimosa"].to_i > 0)
        newCountry[:mimosa_score] = specific_country_rating.first["Rating_Mimosa"].to_i
      end
      if (is_numeric?(specific_country_new_rating.first["GDP"]))
        newCountry[:gdp] = specific_country_new_rating.first["GDP"]
      end
      if (is_numeric?(specific_country_new_rating.first["GDP_per_capita"]))
        newCountry[:gdp_per_capita] = specific_country_new_rating.first["GDP_per_capita"]
      end
      if (is_numeric?(specific_country_new_rating.first["Population"]))
        newCountry[:population] = specific_country_new_rating.first["Population"]
      end
    end
    if(newCountry.key?("rating") == false)
      if (specific_country_rating.length() != 0)
        newCountry[:rating] = specific_country_rating.first["RATING_MOODYS"]
      end
    elsif(newCountry["rating"] == "No Rating")
      if (specific_country_rating.length() != 0)
        newCountry[:rating] = specific_country_rating.first["RATING_MOODYS"]
      end
    end
    if(newCountry.key?("mimosa_score") == false)
      if (specific_country_rating.length() != 0 && is_numeric?(specific_country_rating.first["RATING_MIMOSA"]) && specific_country_rating.first["RATING_MIMOSA"].to_i > 0)
        newCountry[:mimosa_score] = specific_country_rating.first["RATING_MIMOSA"].to_i
      end
    end
    countries_array.push(newCountry)
  end
  fund.countries.create(countries_array.uniq)
  puts"Country Migrated"
end

def country_group_migration(fund, country_group_table)
  country_group_array = []
  country_group_table.each do |row|
    newCountryGroup = {name: row["REGION_NAME"][0..30]}
    country_group_array.push(newCountryGroup)
  end
  fund.country_groups.create(country_group_array.uniq)
  puts"Country Group Migrated"
end

def currency_migration(fund, currency_table, country_ccy_table)
  currency_array = [{short_name: "---", name: "-"}]
  currency_table.each do |row|
    if (row["CCY_ISO"].nil? == false)
      if (row["CCY_ISO"].length() == 3)
        newcurrency = {short_name: row["CCY_ISO"], name: row["CCY_FULLNAME"][0...50]}
        country_ccy_table_filtered = country_ccy_table.find {|item| item["LOCAL_CCY"] == row["CCY_ISO"]}
        if(country_ccy_table_filtered.nil? == false)
          country_linked_toCurrency = Country.find_by(name:country_ccy_table_filtered["COUNTRY_NAME"][0..30])
          if(country_linked_toCurrency.nil? == false)
            newcurrency[:country_id] = country_linked_toCurrency.id
          else
            puts("The country #{country_linked_toCurrency.name} linked to the #{row["CCY_ISO"]} currency isn't in the country list")
          end
        else
          puts("The CCY #{row["CCY_ISO"]} isn't in the database COUNTRY_CCY")
        end
        currency_array.push(newcurrency)
      end
    end
  end
  fund.currencies.create(currency_array.uniq)
  puts"Currency Migrated"
end

def currency_rate_migration(fund, currency_rate_table,admin)
  currency_rate_array = []
  currency_rate_table.each do |row_currency_rate|
    if (row_currency_rate["CCY_ISO"].nil? == false)
      if (row_currency_rate["CCY_ISO"].length() == 3)
        currency_linked = Currency.find_by(short_name: row_currency_rate["CCY_ISO"])
        if (currency_linked.nil? == false)
          if (row_currency_rate["FX_RATE_DATE"].nil? == false)
            corrected_date_string = row_currency_rate["FX_RATE_DATE"][6..7] + "-" + row_currency_rate["FX_RATE_DATE"][3..4] + "-" + row_currency_rate["FX_RATE_DATE"][0..1]
            rateDate = DateTime.parse(corrected_date_string)
            newCurrencyRate = {
              rate: row_currency_rate["FX_RATE"].to_f,
              created_at: rateDate,
              updated_at: rateDate,
              currency_id: currency_linked.id,
              created_by: "#{admin.full_name}",
            }
          else
            newCurrencyRate = {
              rate: row_currency_rate["FX_RATE"].to_f,
              created_at: DateTime.now,
              updated_at: DateTime.now,
              currency_id: currency_linked.id,
              created_by: "#{admin.firstname} + #{admin.lastname}",
            }
          end
          currency_rate_array.push(newCurrencyRate)
        else
          puts("Currency_rate #{row_currency_rate["CCY_ISO"]} was not created because the short_name is not present in the currency database")
        end
      end
    end
  end
  currency_rate_array.sort_by! { |k| k[:created_at] }
  CurrencyRate.create(currency_rate_array)
  puts"Currency rate Migrated"
end
index = 3
def create_pools(fund)
  #Create the targeted pool
  currency_USD = Currency.find_by(short_name: "USD")

  targeted_pool = fund.pools.create(
    name: "Targeted",
    subscription_date: Date.yesterday,
    amount: 23000000.0,
    currency_id: currency_USD.id,
    amount_in_usd: 23000000.0,
    required_specific_reporting: false,
    is_targeted: false,
  )

  # targeted_pool = Pool.find_by(name:"Targeted")

  country_Kenya = {
    pool_id: targeted_pool.id,
    country_id: Country.find_by(name: "Kenya").id,
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
  country_Bolivia = {
    pool_id: targeted_pool.id,
    country_id: Country.find_by(name: "Bolivia").id,
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
  country_Kyrgyzstan = {
    pool_id: targeted_pool.id,
    country_id: Country.find_by(name: "Kyrgyz Republic").id,
    created_at: DateTime.now,
    updated_at: DateTime.now
  }

  PoolCountry.create([country_Kenya,country_Bolivia,country_Kyrgyzstan])

  targeted_pool[:is_targeted] = true
  targeted_pool.save

  #Create Global pool
  fund.pools.create(name: "Global", subscription_date: Date.yesterday)

  puts "Pools Migrated"
end

def institution_group_migration(fund, institution_group_table, admin)
  institution_group_array = []
  institution_group_table.each do |row|
    if (row["GROUP_NAME"].nil? == false)
      if (row["GROUP_NAME"].length() > 1)
        newinstitutionGroup = {name: row["GROUP_NAME"][0...50], created_by: "#{admin.firstname} + #{admin.lastname}"}
        institution_group_array.push(newinstitutionGroup)
      end
    end
  end
  fund.institution_groups.create(institution_group_array.uniq)
  puts"Institution groups Migrated"
end

def status_migration(fund, status_table)
  status_array = []
  status_table.each do |row|
    if (row["STATUS_NAME"].nil? == false)
      mapped_Status = map_status(row["STATUS_NAME"].downcase)
      if(mapped_Status != "NO")
        newStatus = {name: mapped_Status, user_id: 1}
        status_array.push(newStatus)
      end
    end
  end
  fund.statuses.create(status_array.uniq)
  puts"Status Migrated"
end

def link_country_countryGroup(country_table, country_group_table)
  #Loop through the country_group and check for each country_group which country need to be attached to it
  country_group_table.each do |country_group_row|
    country_filtered_table = country_table.select {|item| item["REGION_FK"] == country_group_row["ID_REGION_ID"]}
    #puts "Country Group #{country_group_row["REGION_NAME"]} contains #{country_filtered_table}"
    country_filtered_table.each do |country_row|
      db_country = Country.find_by(name: country_row["COUNTRY_NAME"][0..30])
      if (db_country.nil?)
        puts "The Country #{country_row["COUNTRY_NAME"]} is not in the db"
        puts "Check if the isoCode of #{country_row["COUNTRY_NAME"]} is the same as an other country"
      else
        if (db_country.country_group_id.nil?)
          db_country.country_group_id = CountryGroup.find_by(name: country_group_row["REGION_NAME"][0..30]).id
          db_country.save
        else
          puts "The country #{country_row["COUNTRY_NAME"]} is linked to 2 Country_groups. For now, It will not be saved."
        end
      end
    end
  end
  puts"Country and Country Group linked"
end

def bonds_migration(fund, bond_table)
  bond_array = []
  bond_table.each do |bond_row|
    newBond = {name: bond_row["TYPE_OF_BOND"][0..30], description: "Empty Description"}
    bond_array.push(newBond)
  end
  fund.bonds.create(bond_array.uniq)
  puts"Bonds Migrated"
end

def interest_rate_type_migration(fund, interest_rate_type_table)
  interest_rate_type_array = []
  interest_rate_type_table.each do |interest_rate_type_row|
    newInterest_rate_type = {name: interest_rate_type_row["INTEREST_RATE_TYPE_NAME"][0..30], description: "Empty Description"}
    interest_rate_type_array.push(newInterest_rate_type)
  end
  fund.interest_rate_types.create(interest_rate_type_array.uniq)
  puts"Interest Rate Type Migrated"
end

def loan_types_migration(fund, loan_type_table)
  loan_type_array = []
  loan_type_table.each do |loan_type_row|
    newLoan_type = {name: loan_type_row["TYPE_OF_LOAN_NAME"][0..100]}
    loan_type_array.push(newLoan_type)
  end
  fund.loan_types.create(loan_type_array.uniq)
  puts"Loans Type Migrated"
end

def repayment_type_migration(fund, repayment_type_table)
  repayment_type_array = []
  repayment_type_table.each do |repayment_type_row|
    newRepayment_type = {name: repayment_type_row["REPAYMENT_TYPE_NAME"][0..30].downcase, description: "Empty Description"}
    repayment_type_array.push(newRepayment_type)
  end
  fund.repayment_types.create(repayment_type_array.uniq)
  puts"Repayment Type Migrated"
end

def pool_global_migration(fund, pool_table)
  # It will only create a global pool as the pool system change drasticly
  # We will still need to create pools manually and link it to the correct loans
  pool_array = []
  pool_table.each do |pool_row|
    fund.pools.create(name: pool_row["POOL_NAME"][0..100], subscription_date: Date.yesterday )
  end
  puts"pool Migrated"
end

def loans_migration(fund, position_table, vrr_table, vrr_type_table, provision_table, esticalhisto_table, calendar_table, admin)
  institution_type_array = []
  loan_version_array = []
  loan_array = []

  #The new table only have the last value to use. We don't need to sort it.
  # esticalhisto_table_sorted = esticalhisto_table.sort_by {|row| - (DateTime.parse(row['NAV_DATE'])).to_i}
  esticalhisto_table_sorted = esticalhisto_table

  position_table.each do |position_row|
    # First verify if we know every data "type" present in the position_table
    # if (Status.exists?(['name LIKE ?', "%#{position_row["STATUS"]}%"]) == false)
    #   puts "New STATUS #{position_row["STATUS"]} added to the DB"
    #   fund.statuses.create(name: position_row["STATUS"], user_id: 1)
    # end
    # Remove last empty row from position_row. 
    if(position_row["IM"] == nil)
      puts("IM Group is empty in loan migration for loan #{position_row}")
    else
      if (position_row["BOND"].blank? == false && Bond.exists?(name: position_row["BOND"][0..30]) == false)
        # puts "New BOND #{position_row["BOND"]} added to the DB"
        fund.bonds.create!(name: position_row["BOND"][0..30], description: "Empty Description")
      end
      if (position_row["REPAYMENT_TYPE"].blank? == false && RepaymentType.exists?(name: position_row["REPAYMENT_TYPE"][0..30]) == false)
        # puts "New REPAYMENT_TYPE #{position_row["REPAYMENT_TYPE"]} added to the DB"
        fund.repayment_types.create!(name: position_row["REPAYMENT_TYPE"][0..30].downcase, description: "Empty Description")
      end
      if (position_row["INTEREST_RATE_TYPE"].blank? == false && InterestRateType.exists?(name: position_row["INTEREST_RATE_TYPE"][0..30]) == false)
        # puts "New INTEREST_RATE_TYPE #{position_row["INTEREST_RATE_TYPE"]} added to the DB"
        fund.interest_rate_types.create!(name: position_row["INTEREST_RATE_TYPE"][0..30], description: "Empty Description")
      end
      if (position_row["TYPE_OF_LOAN"].blank? == false && LoanType.exists?(name: position_row["TYPE_OF_LOAN"][0..30]) == false)
        # puts "New TYPE_OF_LOAN #{position_row["TYPE_OF_LOAN"]} added to the DB"
        fund.loan_types.create!(name: position_row["TYPE_OF_LOAN"][0..30])
      end
      if (position_row["InstitutionType"].blank? == false && InstitutionType.exists?(name: position_row["InstitutionType"][0..30]) == false)
        # puts "New InstitutionType #{position_row["InstitutionType"]} added to the DB"
        fund.institution_types.create!(name: position_row["InstitutionType"][0..30])
      end
      if (position_row["GROUP_NAME"].blank? == false && InstitutionGroup.exists?(name: position_row["GROUP_NAME"][0..100]) == false)
        # puts "New InstitutionGroup #{position_row["GROUP_NAME"]} added to the DB"
        fund.institution_groups.create!(name: position_row["GROUP_NAME"][0..100], created_by: "#{admin.firstname} + #{admin.lastname}")
      end
      if (Pool.all.size == 0)
        # puts "Pool Global Created"
        fund.pools.create!(name: "Global", subscription_date: Time.now)
      end
      # Migrate the data from Position

      # Link with ImGroup ID
      if (position_row["IM"] == "")
        puts("ImGroup nil for #{position_row["IM"]}")
        rowImGroupId = nil
      else
        rowImGroup = ImGroup.find_by(name: position_row["IM"][0..100])
        if(rowImGroup == nil)
          break
        else
          rowImGroupId = rowImGroup.id
        end
      end
      newLoan = {
                  noval: position_row["NOVAL"].to_i,
                  innpact_loan_id: position_row["ID_INNPACT"].to_i,
                  creation_user_id: admin.id,
                  im_group_id: rowImGroupId
                }
      #Link the currency
      if (position_row["LOCAL_CCY"].blank? == false && Currency.exists?(short_name: position_row["LOCAL_CCY"]) == true)
        rowPosition_Currency = Currency.find_by(short_name: position_row["LOCAL_CCY"]).id
      else
        # puts "LOCAL CCY #{position_row["LOCAL_CCY"]} for loan #{position_row["ID_INNPACT"]} doesn't match any currency"
        rowPosition_Currency = Currency.find_by(short_name: "---").id
      end
      #Link with InterestRateType id
      if (position_row["INTEREST_RATE_TYPE"] == "")
        rowPosition_InterestRateType = nil
      else
        rowPosition_InterestRateType = InterestRateType.find_by(name: position_row["INTEREST_RATE_TYPE"][0..30]).id
      end
      #Link with bond id
      if (position_row["BOND"] == "")
        rowPosition_Bond = nil
      else
        rowPosition_Bond = Bond.find_by(name: position_row["BOND"][0..30]).id
      end
      #Link with repayment type id
        if (position_row["REPAYMENT_TYPE"] == "")
          rowPosition_RepaymentType = nil
        else
          rowPosition_RepaymentType = RepaymentType.find_by(name: position_row["REPAYMENT_TYPE"][0..30]).id
        end
      #Link with the type of Loan ID
        if (position_row["TYPE_OF_LOAN"] == "")
          rowPosition_LoanType = 1
        else
          rowPosition_LoanType = LoanType.find_by(name: position_row["TYPE_OF_LOAN"][0..100]).id
        end
      # Link with the pool ID
        searched_pool = nil
        if (position_row["POOL"] == "Targeted")
          searched_pool = Pool.find_by(name: position_row["POOL"][0..100])
        elsif(position_row["POOL"] == "Global")
          searched_pool = Pool.find_by(name: position_row["POOL"][0..100])
        end
        if (searched_pool.nil? == false)
          rowPosition_Pool = searched_pool.id
        else
          rowPosition_Pool = Pool.find_by(name: "Global").id
        end

      #Map the old Access DB status with the new SQL database status
      rowPosition_Status = map_status(position_row["STATUS"].downcase)

      # If the status is known we continue, else we don't migrate the loan
      if (rowPosition_Status == "NO")
        puts "Loan status isn't defined for loan #{position_row["ID_INNPACT"]} with status #{position_row["STATUS"].downcase}"
      else
        newLoanVersion = {
          status: rowPosition_Status,
          loan_type_id: rowPosition_LoanType,
          creation_user_id: admin.id,
          currency_id: rowPosition_Currency,
          pool_id: rowPosition_Pool,
          repayment_type_id: rowPosition_RepaymentType,
          executed_bond_id: rowPosition_Bond,
          loan_interest_rate_type_id: rowPosition_InterestRateType,
          version_status: "validated",
          validation_user_id: admin.id,
        }

        if (position_row["APPROVAL_DATE"].nil? == false)
          corrected_date_string = position_row["APPROVAL_DATE"][6..7] + "-" + position_row["APPROVAL_DATE"][3..4] + "-" + position_row["APPROVAL_DATE"][0..1]
          newLoanVersion[:approval_date] = Date.parse(corrected_date_string)
        end
        if (position_row["APPROVED_FIXED_RATE"].nil? == false && position_row["APPROVED_FIXED_RATE"].to_f >= 0.0)
          newLoanVersion[:approved_fixed_rate] = position_row["APPROVED_FIXED_RATE"].to_f
        end
        if (position_row["APPROVED_NOMINAL_LOCAL_CCY"].nil? == false && position_row["APPROVED_NOMINAL_LOCAL_CCY"].to_f >= 0.01)
          newLoanVersion[:approved_nominal_amount] = position_row["APPROVED_NOMINAL_LOCAL_CCY"].to_f
        end
        if (position_row["APPROVED_SPREAD"].nil? == false && position_row["APPROVED_SPREAD"].to_f >= 0.01)
          newLoanVersion[:approved_spread] = position_row["APPROVED_SPREAD"].to_f
        end
        if (position_row["APPROVED_TENOR"].nil? == false && position_row["APPROVED_TENOR"].to_i > 0.01)
          newLoanVersion[:approved_tenor] = position_row["APPROVED_TENOR"].to_i
        end
        if (position_row["APPROVED_UPFRONT"].nil? == false && position_row["APPROVED_UPFRONT"].to_f >= 0.0)
          newLoanVersion[:approved_upfront_fees] = position_row["APPROVED_UPFRONT"].to_f
        end
        if (rowPosition_Status == "pending_approval" && position_row["RATIFIED_NOMINAL_LOCAL_CCY"].to_f >= 0.01)
          newLoanVersion[:pending_approval_nominal_amount] = position_row["RATIFIED_NOMINAL_LOCAL_CCY"].to_f
        end
        if (rowPosition_Status == "pending_approval" && position_row["RATIFIED_FIXED_RATE"].to_f >= 0.0)
          newLoanVersion[:pending_approval_fixed_rate] = position_row["RATIFIED_FIXED_RATE"].to_f
        end
        if (rowPosition_Status == "pending_approval" && position_row["RATIFIED_SPREAD"].to_f >= 0.01)
          newLoanVersion[:pending_approval_spread] = position_row["RATIFIED_SPREAD"].to_f
        end
        if (rowPosition_Status == "pending_approval" && position_row["RATIFIED_TENOR"].to_f >= 0.01)
          newLoanVersion[:pending_approval_tenor] = position_row["RATIFIED_TENOR"].to_f
        end
        if (rowPosition_Status == "pending_approval" && position_row["RATIFIED_UPFRONT"].to_f >= 0.0)
          newLoanVersion[:pending_approval_upfront_fees] = position_row["RATIFIED_UPFRONT"].to_f
        end
        if (rowPosition_Status == "pending_approval" && position_row["RATIFICATION_DATE"].nil? == false)
          corrected_date_string = position_row["RATIFICATION_DATE"][6..7] + "-" + position_row["RATIFICATION_DATE"][3..4] + "-" + position_row["RATIFICATION_DATE"][0..1]
          newLoanVersion[:pending_approval_date] = Date.parse(corrected_date_string)
        end
        if (rowPosition_Status == "pending_approval" && position_row["DEADLINE_RATIFICATION_DATE"].nil? == false)
          corrected_date_string = position_row["DEADLINE_RATIFICATION_DATE"][6..7] + "-" + position_row["DEADLINE_RATIFICATION_DATE"][3..4] + "-" + position_row["DEADLINE_RATIFICATION_DATE"][0..1]
          newLoanVersion[:deadline_pending_approval_date] = Date.parse(corrected_date_string)
        end
        if (rowPosition_Status == "pending_ratification" && position_row["ORIGINAL_NOMINAL_LOCAL_CCY"].to_f >= 0.01)
          newLoanVersion[:pending_ratification_nominal_amount] = position_row["ORIGINAL_NOMINAL_LOCAL_CCY"].to_f
        end
        if (rowPosition_Status == "pending_ratification" && position_row["PROPOSED_FIXED_RATE"].to_f >= 0.0)
          newLoanVersion[:pending_ratification_fixed_rate] = position_row["PROPOSED_FIXED_RATE"].to_f
        end
        if (rowPosition_Status == "pending_ratification" && position_row["PROPOSED_SPREAD"].to_f >= 0.01)
          newLoanVersion[:pending_ratification_spread] = position_row["PROPOSED_SPREAD"].to_f
        end
        if (rowPosition_Status == "pending_ratification" && position_row["ORIGINAL_TENOR"].to_f >= 0.01)
          newLoanVersion[:pending_ratification_tenor] = position_row["ORIGINAL_TENOR"].to_f
        end
        if (rowPosition_Status == "pending_ratification" && position_row["PROPOSED_UPFRONT"].to_f >= 0.0)
          newLoanVersion[:pending_ratification_upfront_fees] = position_row["PROPOSED_UPFRONT"].to_f
        end
        if (rowPosition_Status == "pending_ratification" && position_row["ASSIGNMENT_DATE"].nil? == false)
          corrected_date_string = position_row["ASSIGNMENT_DATE"][6..7] + "-" + position_row["ASSIGNMENT_DATE"][3..4] + "-" + position_row["ASSIGNMENT_DATE"][0..1]
          newLoanVersion[:pending_ratification_date] = Date.parse(corrected_date_string)
        end
        if (rowPosition_Status == "pending_ratification" && position_row["DEADLINE_ASSIGNMENT_DATE"].nil? == false)
          corrected_date_string = position_row["DEADLINE_ASSIGNMENT_DATE"][6..7] + "-" + position_row["DEADLINE_ASSIGNMENT_DATE"][3..4] + "-" + position_row["DEADLINE_ASSIGNMENT_DATE"][0..1]
          newLoanVersion[:deadline_pending_ratification_date] = Date.parse(corrected_date_string)
        end
        if (rowPosition_Status == "approved_change_request" && position_row["RATIFIED_NOMINAL_LOCAL_CCY"].to_f >= 0.01)
          newLoanVersion[:approved_change_request_nominal_amount] = position_row["RATIFIED_NOMINAL_LOCAL_CCY"].to_f
        end
        if (rowPosition_Status == "approved_change_request" && position_row["RATIFIED_FIXED_RATE"].to_f >= 0.0)
          newLoanVersion[:approved_change_request_fixed_rate] = position_row["RATIFIED_FIXED_RATE"].to_f
        end
        if (rowPosition_Status == "approved_change_request" && position_row["RATIFIED_SPREAD"].to_f >= 0.01)
          newLoanVersion[:approved_change_request_spread] = position_row["RATIFIED_SPREAD"].to_f
        end
        if (rowPosition_Status == "approved_change_request" && position_row["RATIFIED_TENOR"].to_f >= 0.01)
          newLoanVersion[:approved_change_request_tenor] = position_row["RATIFIED_TENOR"].to_f
        end
        if (rowPosition_Status == "approved_change_request" && position_row["RATIFIED_UPFRONT"].to_f >= 0.0)
          newLoanVersion[:approved_change_request_upfront_fees] = position_row["RATIFIED_UPFRONT"].to_f
        end
        if (position_row["ASSIGNMENT_DATE"].nil? == false)
          corrected_date_string = position_row["ASSIGNMENT_DATE"][6..7] + "-" + position_row["ASSIGNMENT_DATE"][3..4] + "-" + position_row["ASSIGNMENT_DATE"][0..1]
          newLoanVersion[:assignment_date] = Date.parse(corrected_date_string)
        end
        if (position_row["DEADLINE_APPROVAL_DATE"].nil? == false)
          corrected_date_string = position_row["DEADLINE_APPROVAL_DATE"][6..7] + "-" + position_row["DEADLINE_APPROVAL_DATE"][3..4] + "-" + position_row["DEADLINE_APPROVAL_DATE"][0..1]
          newLoanVersion[:deadline_approval_date] = Date.parse(corrected_date_string)
        end
        if (position_row["DEADLINE_ASSIGNMENT_DATE"].nil? == false)
          corrected_date_string = position_row["DEADLINE_ASSIGNMENT_DATE"][6..7] + "-" + position_row["DEADLINE_ASSIGNMENT_DATE"][3..4] + "-" + position_row["DEADLINE_ASSIGNMENT_DATE"][0..1]
          newLoanVersion[:deadline_assignment_date] = Date.parse(corrected_date_string)
        end
        if (position_row["DISBURSEMENT_DATE"].nil? == false)
          corrected_date_string = position_row["DISBURSEMENT_DATE"][6..7] + "-" + position_row["DISBURSEMENT_DATE"][3..4] + "-" + position_row["DISBURSEMENT_DATE"][0..1]
          newLoanVersion[:disbursement_date] = Date.parse(corrected_date_string)
        end
        if (position_row["EXECUTED_FIXED_RATE"].nil? == false && position_row["EXECUTED_FIXED_RATE"].to_f >= 0.0)
          newLoanVersion[:executed_fixed_rate] = position_row["EXECUTED_FIXED_RATE"].to_f
        end
        if (position_row["NOMINAL_LOCAL_CCY"].nil? == false && position_row["NOMINAL_LOCAL_CCY"].to_f >= 0.01)
          newLoanVersion[:executed_nominal_amount] = position_row["NOMINAL_LOCAL_CCY"].to_f
        elsif(position_row["NOMINAL_AMOUNT_USD"].nil? == false && position_row["NOMINAL_AMOUNT_USD"].to_f >= 0.01 && position_row["LOCAL_CCY"] == "USD")
          newLoanVersion[:executed_nominal_amount] = position_row["NOMINAL_AMOUNT_USD"].to_f
        end
        if (position_row["EXECUTED_SPREAD"].nil? == false  && position_row["EXECUTED_SPREAD"].to_f >= 0.01)
          newLoanVersion[:loan_spread] = position_row["EXECUTED_SPREAD"].to_f
        end
        if (position_row["TENOR"].nil? == false && position_row["TENOR"].to_i > 0.01)
          newLoanVersion[:executed_tenor] = position_row["TENOR"].to_i
        end
        if (position_row["EXECUTED_UPFRONT"].nil? == false  && position_row["EXECUTED_UPFRONT"].to_f >= 0.0)
          newLoanVersion[:executed_upfront_fees] = position_row["EXECUTED_UPFRONT"].to_f
        end
        if (position_row["EXPECTED_DISBURSEMENT_DATE"].nil? == false)
          corrected_date_string = position_row["EXPECTED_DISBURSEMENT_DATE"][6..7] + "-" + position_row["EXPECTED_DISBURSEMENT_DATE"][3..4] + "-" + position_row["EXPECTED_DISBURSEMENT_DATE"][0..1]
          newLoanVersion[:expected_disbursement_date] = Date.parse(corrected_date_string)
        end
        if (position_row["MATURITY_DATE"].nil? == false)
          corrected_date_string = position_row["MATURITY_DATE"][6..7] + "-" + position_row["MATURITY_DATE"][3..4] + "-" + position_row["MATURITY_DATE"][0..1]
          newLoanVersion[:maturity_date] = Date.parse(corrected_date_string)
        end
        if (position_row["PROBABILITIES"].nil? == false)
          newLoanVersion[:probabilities] = position_row["PROBABILITIES"].to_f
        end
        if (position_row["PROPOSED_FIXED_RATE"].nil? == false && position_row["PROPOSED_FIXED_RATE"].to_f >= 0.0)
          newLoanVersion[:proposed_fixed_rate] = position_row["PROPOSED_FIXED_RATE"].to_f
        end
        if (position_row["ORIGINAL_NOMINAL_LOCAL_CCY"].nil? == false && position_row["ORIGINAL_NOMINAL_LOCAL_CCY"].to_f >= 0.01)
          newLoanVersion[:proposed_nominal_amount] = position_row["ORIGINAL_NOMINAL_LOCAL_CCY"].to_f
        end
        if (position_row["PROPOSED_SPREAD"].nil? == false && position_row["PROPOSED_SPREAD"].to_f >= 0.01)
          newLoanVersion[:proposed_spread] = position_row["PROPOSED_SPREAD"].to_f
        end
        if (position_row["ORIGINAL_TENOR"].nil? == false && position_row["ORIGINAL_TENOR"].to_i > 0.01)
          newLoanVersion[:proposed_tenor] = position_row["ORIGINAL_TENOR"].to_i
        end
        if (position_row["PROPOSED_UPFRONT"].nil? == false && position_row["PROPOSED_UPFRONT"].to_f >= 0.0)
          newLoanVersion[:proposed_upfront_fees] = position_row["PROPOSED_UPFRONT"].to_f
        end
        if (position_row["DEADLINE_RATIFICATION_DATE"].nil? == false)
          corrected_date_string = position_row["DEADLINE_RATIFICATION_DATE"][6..7] + "-" + position_row["DEADLINE_RATIFICATION_DATE"][3..4] + "-" + position_row["DEADLINE_RATIFICATION_DATE"][0..1]
          newLoanVersion[:deadline_ratification_date] = Date.parse(corrected_date_string)
        end
        if (position_row["RATIFICATION_DATE"].nil? == false)
          corrected_date_string = position_row["RATIFICATION_DATE"][6..7] + "-" + position_row["RATIFICATION_DATE"][3..4] + "-" + position_row["RATIFICATION_DATE"][0..1]
          newLoanVersion[:ratification_date] = Date.parse(corrected_date_string)
        end
        if (position_row["RATIFIED_FIXED_RATE"].nil? == false && position_row["RATIFIED_FIXED_RATE"].to_f >= 0.0)
          newLoanVersion[:ratified_fixed_rate] = position_row["RATIFIED_FIXED_RATE"].to_f
        end
        if (position_row["RATIFIED_NOMINAL_LOCAL_CCY"].nil? == false && position_row["RATIFIED_NOMINAL_LOCAL_CCY"].to_f >= 0.01)
          newLoanVersion[:ratified_nominal_amount] = position_row["RATIFIED_NOMINAL_LOCAL_CCY"].to_f
        end
        if (position_row["RATIFIED_SPREAD"].nil? == false && position_row["RATIFIED_SPREAD"].to_f >= 0.01)
          newLoanVersion[:ratified_spread] = position_row["RATIFIED_SPREAD"].to_f
        end
        if (position_row["RATIFIED_TENOR"].nil? == false && position_row["RATIFIED_TENOR"].to_i > 0.0)
          newLoanVersion[:ratified_tenor] = position_row["RATIFIED_TENOR"].to_i
        end
        if (position_row["RATIFIED_UPFRONT"].nil? == false && position_row["RATIFIED_UPFRONT"].to_f >= 0.0)
          newLoanVersion[:ratified_upfront_fees] = position_row["RATIFIED_UPFRONT"].to_f
        end
        if (position_row["SPECIFIC_APPROVAL_CONDITION"].nil? == false)
          newLoanVersion[:specific_approval_condition] = position_row["SPECIFIC_APPROVAL_CONDITION"]
        end
        newLoanVersion[:critical_cases] = 'FALSE'
        #Migrate Hedge Structure
        if (position_row["TYPE_HEDGE_STUCTURE"].nil? == false)
          newLoanVersion[:hedge_comment] = position_row["TYPE_HEDGE_STUCTURE"]
        end

        #Migrate the comment from loan version
        if (position_row["SPECIFIC_APPROVAL_CONDITION"].nil? == false)
          case rowPosition_Status
            when "approval_expired"
              newLoanVersion[:approval_expired_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
            when "approved_change_request"
              newLoanVersion[:approved_change_request_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
            when "approved"
              newLoanVersion[:approved_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
            when "assignement_expired"
              newLoanVersion[:assignement_expired_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
            when "invested"
              newLoanVersion[:invested_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
            when "not_approved"
              newLoanVersion[:not_approved_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
            when "not_ratified"
              newLoanVersion[:not_ratified_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
            when "not_validated"
              newLoanVersion[:not_validated_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
            when "pending_approval"
              newLoanVersion[:pending_approval_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
            when "pending_ratification"
              newLoanVersion[:pending_ratification_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
            when "ratified"
              newLoanVersion[:ratified_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
            when "released_after_approval"
              newLoanVersion[:released_after_approval_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
            when "released_before_approval"
              newLoanVersion[:released_before_approval_comment] = position_row["SPECIFIC_APPROVAL_CONDITION"]
          end
        end

        # Migrate the VRR variable
        row_vrr = vrr_table.find {|item| item["ID_INNPACT"] == position_row["ID_INNPACT"].to_s}
        if (row_vrr.nil? == false)
          vrr = row_vrr["VRR"]
          newLoanVersion[:vrr] = vrr

          row_vrr_maturity = vrr_type_table.find {|item| item["Legal_Classification"] == vrr}
          if (row_vrr_maturity.nil? == false)
            vrr_maturity_date = row_vrr_maturity["VRR_Maturity_Date"]
            newLoanVersion[:vrr_maturity_date] = vrr_maturity_date
          end
        end

        #Migrate the Nav variable
        # if (newLoanVersion[:status] == "invested" || newLoanVersion[:status] == "matured")
        #   filtered_nav_tab = esticalhisto_table_sorted.find {|item| item["NOVAL"].to_i == newLoan[:noval]}
        #   if (filtered_nav_tab.nil? == false)
        #     newLoanVersion[:nav_usd] = filtered_nav_tab["NAV_USD"].to_f
        #     corrected_date_string = filtered_nav_tab["NAV_DATE"][6..7] + "-" + filtered_nav_tab["NAV_DATE"][3..4] + "-" + filtered_nav_tab["NAV_DATE"][0..1]
        #     newLoanVersion[:nav_date] = Date.parse(corrected_date_string)
        #   end
        # else
        #   newLoanVersion[:nav_usd] = 0
        # end
        filtered_nav_tab = esticalhisto_table_sorted.find {|item| item["NOVAL"].to_i == newLoan[:noval]}
        if (filtered_nav_tab.nil? == false)
          newLoanVersion[:nav_usd] = filtered_nav_tab["NAV_USD"].to_f
          corrected_date_string = "2021-09-30"
          newLoanVersion[:nav_date] = Date.parse(corrected_date_string)
        else
          newLoanVersion[:nav_usd] = 0
          corrected_date_string = "2021-09-30"
          newLoanVersion[:nav_date] = Date.parse(corrected_date_string)
        end
        fund.loans.create!(newLoan).loan_versions.create!(newLoanVersion)
      end # If loans status is not defined
    end #End If IM Group is not empty
  end # Do for Each
  puts"Loans Migrated"
end

def institutions_migration(fund, institution_table, country_table, position_table, investment_manager)
  institution_array = []
  institution_table.each do |row|
    if(row.nil? == false)
      country_institution = country_table.find {|item| item["ID_COUNTRY_ID"].to_s == row["COUNTRY_ID"].to_s}
      if (country_institution.nil? == false)
        db_country = Country.find_by(name: country_institution["COUNTRY_NAME"][0..30])
        if (db_country.nil? == false)
          newinstitution = {  name: row["MFI_NAME"][0...100],
                              country_id: db_country.id,
                              im_group_id: 1,
                            }
          position_filtered_institution = position_table.select {|item| item["MFI_NAME_ACTUAL"] == row["MFI_NAME"]}
          # Get data from the position table linked to institution
          if(position_filtered_institution == [])
            puts "The instistution: #{row["MFI_NAME"]} got no loans in the database"
          else
            position_institution_groupName_filtered = position_filtered_institution.find {|item| item["GROUP_NAME"].nil? == false}
            if (position_institution_groupName_filtered.nil? == false && position_institution_groupName_filtered["GROUP_NAME"] != "" && position_institution_groupName_filtered["GROUP_NAME"] != " ")
              institution_group_name = position_institution_groupName_filtered["GROUP_NAME"]
            else
              institution_group_name = "-"
            end
            newinstitution[:institution_group_id] = InstitutionGroup.find_by(name: institution_group_name[0..100]).id

            position_institution_InstitutionType_filtered = position_filtered_institution.find {|item| item["InstitutionType"].nil? == false}
            if (position_institution_InstitutionType_filtered.nil? == false && position_institution_InstitutionType_filtered["InstitutionType"] != "" && position_institution_InstitutionType_filtered["InstitutionType"] != " " && position_institution_InstitutionType_filtered["InstitutionType"] != "-")
              institution_type_name = position_institution_InstitutionType_filtered["InstitutionType"]
            else
              institution_type_name = "Other"
            end
            newinstitution[:institution_type_id] = InstitutionType.find_by(name: institution_type_name[0..30]).id

            position_institution_imGroup_filtered = position_filtered_institution.find {|item| (item["IM"].nil? == false && item["STATUS"] == "Matured")}
            if (position_institution_imGroup_filtered.nil? == false)
              institution_IM = position_institution_imGroup_filtered["IM"]
            else
              position_institution_imGroup_filtered = position_filtered_institution.find {|item| item["IM"].nil? == false}
              if (position_institution_imGroup_filtered.nil? == false)
                institution_IM = position_institution_imGroup_filtered["IM"]
              else
                institution_IM = nil
              end
            end
            if(institution_IM.nil? == false)
              newinstitution[:im_group_id] = ImGroup.find_by(name: institution_IM[0..100]).id
            end
            # By default the institution watchlist in false
            # Later it will turn true if the critical case of a loan version linked to the institution is true
            newinstitution[:in_watchlist] = false

            institution_array.push(newinstitution)
          end
        else
          puts "Issue with institution #{row["MFI_NAME"]}, country #{row["COUNTRY_FK"]} match an ID but don't match a name"
        end
      else
        puts "Issue with institution #{row["MFI_NAME"]}, country #{row["COUNTRY_FK"]} doesn't match any known ID"
      end
    end
  end

  # fund.institutions.create!(institution_array.uniq)

  institution_array.uniq.each do |institution|
    new_institution = fund.institutions.build(institution)
    # pp new_institution.inspect
    unless new_institution.save
      puts new_institution.errors.full_messages
    end
  end
  puts"institutions Migrated"
end

def link_institution_loans(position_table)
  db_loans = Loan.all
  db_loans.each do |row_Loan|
    if(row_Loan.nil? == false)
      position_table_loan_filtered = position_table.find {|item| item["ID_INNPACT"] == row_Loan.innpact_loan_id.to_s}
      if(position_table_loan_filtered.nil? == false && position_table_loan_filtered["MFI_NAME_ACTUAL"].blank? == false && Institution.exists?(name: position_table_loan_filtered["MFI_NAME_ACTUAL"][0...100]) == true)
        row_Loan.institution_id =  Institution.find_by(name: position_table_loan_filtered["MFI_NAME_ACTUAL"][0..100]).id
        row_Loan.last_loan_version = LoanVersion.find_by(loan_id: row_Loan.id).version_number
        row_Loan.save
      else
        puts "Didn't found the institution linked to the ID INNPACT #{row_Loan.innpact_loan_id}"
      end
    end
  end
end

def imGroup_migration(fund, imGroup_table)
  imGroup_array = []
  imGroup_table.each do |imGroup_row|
    newImGroup = {
      name: imGroup_row["IM_NAME"][0..100],
    }
    imGroup_array.push(newImGroup)
  end
  fund.im_groups.create(imGroup_array)
  puts"IM_Group has been migrated"
end

def repayment_calendar_migration(fund, calendar_table, admin)
  puts("Start repayment calendar migration")
  loan_versions = LoanVersion.all
  loans = Loan.all
  #Migrate the calendar variables
  unique_calendar_noval = calendar_table["NOVAL"].uniq
  unique_calendar_noval.each do |unique_calendar_noval_row|
    loan_filtered = loans.find_by(noval: unique_calendar_noval_row)
    if(loan_filtered.nil? == false)
      loan_versions_filtered = loan_versions.find_by(loan_id: loan_filtered.id)
      if(loan_versions_filtered.nil? == false)
        newRepaymentCalendar = {
          creation_user_id: admin.id,
          loan_version_id: loan_versions_filtered.id,
        }
        filtered_calendar_line = calendar_table.select {|item| item["NOVAL"] == unique_calendar_noval_row}
        repayment_calendar_line_array = []
        corrected_date_string = ""
        filtered_calendar_line.each do |filtered_calendar_line_row|
          if(filtered_calendar_line_row["REPAYMENT DATE"] == nil)
            puts(filtered_calendar_line_row)
          end
          corrected_date_string = filtered_calendar_line_row["REPAYMENT DATE"][6..7] + "-" + filtered_calendar_line_row["REPAYMENT DATE"][3..4] + "-" + filtered_calendar_line_row["REPAYMENT DATE"][0..1]
          newRepaymentCalendarLine = {
            repayment_date: Date.parse(corrected_date_string),
            repayment_type: filtered_calendar_line_row["TYPE OF PAYMENT"] == "Principal" ? "principal" : "interest",
            original_amount: filtered_calendar_line_row["Original amount"].to_f,
            received_amount: filtered_calendar_line_row["Received amount"].to_f,
            status: filtered_calendar_line_row["Payment Status"].downcase,
            provision: filtered_calendar_line_row["Provision"].to_f,
            created_at: DateTime.now,
            updated_at: DateTime.now,
          }
          repayment_calendar_line_array.push(newRepaymentCalendarLine)
        end
        repaymentcalendar = RepaymentCalendar.new(newRepaymentCalendar)
        repaymentcalendar.repayment_calendar_lines.build(repayment_calendar_line_array)
        repaymentcalendar.save
      end
    end
  end
  puts("end repayment calendar migration")
end

def provision_migration(calendar_table)
  db_repaymentCalendar = RepaymentCalendar.all

  if(db_repaymentCalendar.nil? == false)
    db_repaymentCalendar.each do |repaymentCalendar_row|
      db_loan_version = LoanVersion.find_by(id: repaymentCalendar_row.loan_version_id)
      sum_provision = 0
      #Value asked by Innpact
      date_provision = Date.parse("2021-12-31")
      db_repaymentCalendarLines = RepaymentCalendarLine.where(repayment_calendar_id: repaymentCalendar_row.id)
      if(db_repaymentCalendarLines.nil? == false)
        db_repaymentCalendarLines.each do |repaymentCalendarLine_row|
          sum_provision += repaymentCalendarLine_row.provision.to_f
        end
      end
      if(sum_provision != 0)
        db_loan_version[:provision_value] = sum_provision
        db_loan_version[:provision_date] = date_provision
        db_loan_version[:critical_cases] = 'TRUE'
        db_loan_version.save
      end
    end
  end
end

def gross_net_amount_migration()
  db_repaymentCalendar = RepaymentCalendar.all

  if(db_repaymentCalendar.nil? == false)
    db_repaymentCalendar.each do |repaymentCalendar_row|
      db_loan_version = LoanVersion.find_by(id: repaymentCalendar_row.loan_version_id)
      sum_paid_amount = 0
      db_repaymentCalendarLines = RepaymentCalendarLine.where(repayment_calendar_id: repaymentCalendar_row.id, status: "paid")
      if(db_repaymentCalendarLines.nil? == false)
        db_repaymentCalendarLines.each do |repaymentCalendarLine_row|
          sum_paid_amount += repaymentCalendarLine_row.received_amount.to_f
        end
      end
      if(db_loan_version[:executed_nominal_amount].nil? == false)
        db_loan_version[:gross_position_value] = db_loan_version[:executed_nominal_amount].to_f - sum_paid_amount
      end
      if(db_loan_version[:gross_position_value].nil? == false && db_loan_version[:provision_value].nil? == false)
        db_loan_version[:net_position_value] = db_loan_version[:gross_position_value].to_f - db_loan_version[:provision_value].to_f
      elsif(db_loan_version[:gross_position_value].nil? == false && db_loan_version[:provision_value].nil? == true)
        db_loan_version[:net_position_value] = db_loan_version[:gross_position_value].to_f
      end
      db_loan_version.save
    end
  end
end

def tranche_migration(position_table)
  loans = Loan.all
  loans.each do |loans_row|
    #Check each existing Loan and filter the position table parent noval loan value to see loan children
    position_table_tranche_filtered = position_table.find {|item| item["Parent Loan Noval"] == loans_row.noval.to_s}
    if (position_table_tranche_filtered.nil? == false) 
      maxTrancheNumber = 1
      #Check what is the maximum number of tranche in the DB (The value is cap to 50)
      while maxTrancheNumber < 100
        if((position_table.find {|item| item["TRANCHE"] == (maxTrancheNumber + 1).to_s}).nil?)
          break
        else
          maxTrancheNumber = maxTrancheNumber + 1
        end
      end
      index = 1
      while index <= maxTrancheNumber
        #For each child, filter with the tranche number 1,2,3... in order
        index_ordered_tranche = position_table.find {|item| item["TRANCHE"] == index.to_s && item["Parent Loan Noval"] == loans_row.noval.to_s}
        if(index_ordered_tranche.nil? == false && index_ordered_tranche["Parent Loan Noval"] != index_ordered_tranche['NOVAL'])
          corrected_date_string = index_ordered_tranche["CREATION_DATE"][6..7] + "-" + index_ordered_tranche["CREATION_DATE"][3..4] + "-" + index_ordered_tranche["CREATION_DATE"][0..1]
          toUpdateLoan = Loan.find_by(innpact_loan_id: index_ordered_tranche["ID_INNPACT"])
          toUpdateLoan[:original_loan_id] = loans_row.id
          toUpdateLoan[:copied_at] = Date.parse(corrected_date_string)
          toUpdateLoan.save
        end
        index = index + 1
      end
    end
  end
end

def inWatchList_InstitutionMigration()
  criticalCaseLoans = LoanVersion.where(critical_cases: 'TRUE')
  criticalCaseLoans.each do |criticalCase_row|
    filteredLoan = Loan.find_by(id: criticalCase_row.loan_id)
    filteredInstitution = Institution.find_by(id: filteredLoan.institution_id)
    filteredInstitution[:in_watchlist] = true
    filteredInstitution[:watchlist_reason] = "loan is critical case"
    filteredInstitution.save
  end
end

def report_loans(position_table)
  loan_versions = LoanVersion.all
  loans = Loan.all
  position_table.each do |positionTable_row|
    loan_filtered = loans.find_by(innpact_loan_id: positionTable_row["ID_INNPACT"])
    if(loan_filtered.nil? == false)
      loan_versions_filtered = loan_versions.find_by(loan_id: loan_filtered.id)
      if(loan_versions_filtered.nil?)
        puts("The loan #{positionTable_row["ID_INNPACT"]} has not been migrated into the database")
      end
    else
      puts("The loan #{positionTable_row["ID_INNPACT"]} has not been migrated into the database")
    end
  end
end

def report_institutions(institution_table)
  institutions = Institution.all
  institution_table.each do |institutionTable_row|
    if(institutionTable_row["MFI_NAME"].nil? == false)
      institutions_filtered = institutions.find_by(name: institutionTable_row["MFI_NAME"][0...100])
    else
      institutions_filtered = nil
    end
    if(institutions_filtered.nil?)
      puts("The institution #{institutionTable_row["MFI_NAME"]} has not been migrated into the database")
    end
  end
end

def report_institutionsGroup(institution_group_table)
  institutionsGroup = InstitutionGroup.all
  institution_group_table.each do |institutionGroupTable_row|
    if(institutionGroupTable_row["GROUP_NAME"].nil? == false)
      institutionsGroup_filtered = institutionsGroup.find_by(name: institutionGroupTable_row["GROUP_NAME"][0...100])
    else
      institutionsGroup_filtered = nil
    end
    if(institutionsGroup_filtered.nil?)
      puts("The institution Group #{institutionGroupTable_row["GROUP_NAME"]} has not been migrated into the database")
    end
  end
end

def report_repaymentCalendar(fund, calendar_table)
  repaymentCalendar = RepaymentCalendar.all
  loan_versions = LoanVersion.all
  loans = Loan.all

  loanNotFound = []
  loanVersionNotFound = []
  calendarNotCreated = []

  unique_calendar_noval = calendar_table["NOVAL"].uniq
  unique_calendar_noval.each do |unique_calendar_noval_row|
    loan_filtered = loans.find_by(noval: unique_calendar_noval_row)
    if(loan_filtered.nil? == false)
      loan_versions_filtered = loan_versions.find_by(loan_id: loan_filtered.id)
      if(loan_versions_filtered.nil? == false)
        repaymentCalendar_filtered = repaymentCalendar.find_by(loan_version_id: loan_versions_filtered.id)
        if(repaymentCalendar_filtered.nil? == true)
          # calendarNotCreated.push(calendar_table.find{|item| item["NOVAL"] == unique_calendar_noval_row}["MFI_NAME"])
          calendarNotCreated.push(unique_calendar_noval_row)
        end
      else
        # loanVersionNotFound.push(calendar_table.find{|item| item["NOVAL"] == unique_calendar_noval_row}["MFI_NAME"])
        loanVersionNotFound.push(unique_calendar_noval_row)
      end
    else
      # loanNotFound.push(calendar_table.find{|item| item["NOVAL"] == unique_calendar_noval_row}["MFI_NAME"])
      loanNotFound.push(unique_calendar_noval_row)
    end
  end
  puts("******************Repayment Calendar not migrated******************")
  puts(calendarNotCreated)
  puts("******************Repayment Calendar not migrated due to Loan Not Found******************")
  puts(loanNotFound)
  puts("******************Repayment Calendar not migrated due to LoanVersion Not Found******************")
  puts(loanVersionNotFound)

end

namespace :db do
  desc "Migration of the data from csv table of Innpact database."
  task data_migration: :environment do
    require 'csv'

    admin = User.create!({
                                email: "admin@innpact.com",
                                password: 'password',
                                password_confirmation: 'password',
                                firstname: 'Admin',
                                lastname: 'Innpact'
                              })
    admin.add_role(:administrator)
    system = User.create!({
                            email: 'system@innpact.com',
                            password: 'password',
                            password_confirmation: 'password',
                            firstname: 'System',
                            lastname: 'Innpact'
                          })
    system.add_role(:system)
    fund = Fund.create!(
    {
      name: "MEF",
      created_by: "#{admin.firstname} + #{admin.lastname}"
    }.merge(status: :active))

    country_table = CSV.parse(File.read(_localpath + _csv_path + _country_path), col_sep: ';', headers: true)
    country_rating = CSV.parse(File.read(_localpath + _csv_path + _rating_path), col_sep: ';', headers: true)
    country_new_rating = CSV.parse(File.read(_localpath + _csv_path + _new_rating_path), col_sep: ';', headers: true)
    country_group_table = CSV.parse(File.read(_localpath + _csv_path + _region_path), col_sep: ';', headers: true)
    currency_table = CSV.parse(File.read(_localpath + _csv_path + _currency_path), col_sep: ';', headers: true)
    currency_rate_table = CSV.parse(File.read(_localpath + _csv_path + _currency_rate_path), col_sep: ';', headers: true)
    #institution_group_table need to be ; separated for "," string issue
    institution_group_table = CSV.parse(File.read(_localpath + _csv_path + _institution_group_path), col_sep: ';', headers: true)
    status_table = CSV.parse(File.read(_localpath + _csv_path + _status_path), col_sep: ';', headers: true)
    bond_table = CSV.parse(File.read(_localpath + _csv_path + _bond_path), col_sep: ';', headers: true)
    interest_rate_type_table = CSV.parse(File.read(_localpath + _csv_path + _interest_rate_type_path), col_sep: ';', headers: true)
    loan_type_table = CSV.parse(File.read(_localpath + _csv_path + _loan_type_path), col_sep: ';', headers: true)
    repayment_type_table = CSV.parse(File.read(_localpath + _csv_path + _repayment_type_path), col_sep: ';', headers: true)
    pool_table = CSV.parse(File.read(_localpath + _csv_path + _pool_path), col_sep: ';', headers: true)
    #Position_table need to be ; separated for "," string issue
    position_table = CSV.parse(File.read(_localpath + _csv_path + _position_path), col_sep: ';', headers: true)
    vrr_table = CSV.parse(File.read(_localpath + _csv_path + _vrr_path), headers: true)
    vrr_type_table = CSV.parse(File.read(_localpath + _csv_path + _vrr_type_path), headers: true)
    #provision_table need to be ; separated for "," string issue
    provision_table = CSV.parse(File.read(_localpath + _csv_path + _provision_path), col_sep: ';', headers: true)
    #MFI_Tab need to be ; separated for "," string issue
    institution_table = CSV.parse(File.read(_localpath + _csv_path + _institution_path), col_sep: ';', headers: true)
    imGroup_table = CSV.parse(File.read(_localpath + _csv_path + _imGroup_path), col_sep: ';', headers: true)
    #esticalhisto_table need to be ; separated for "," string issue
    esticalhisto_table = CSV.parse(File.read(_localpath + _csv_path + _esticalhisto_path), col_sep: ';', headers: true)
    country_ccy_table = CSV.parse(File.read(_localpath + _csv_path + _country_CCY_path), headers: true)
    #calendar_table need to be ; separated for "," string issue
    calendar_table = CSV.parse(File.read(_localpath + _csv_path + _calendar_path), col_sep: ';', headers: true)

    puts"Start Migration"
    imGroup_migration(fund, imGroup_table)
    country_migration(fund, country_table, country_rating, country_new_rating, country_to_iso, admin)
    country_group_migration(fund, country_group_table)
    link_country_countryGroup(country_table, country_group_table)
    currency_migration(fund, currency_table, country_ccy_table)
    currency_rate_migration(fund, currency_rate_table, admin)
    institution_group_migration(fund, institution_group_table, admin)
    status_migration(fund, status_table)
    bonds_migration(fund, bond_table)
    interest_rate_type_migration(fund, interest_rate_type_table)
    loan_types_migration(fund, loan_type_table)
    repayment_type_migration(fund, repayment_type_table)
    create_pools(fund)
    loans_migration(fund, position_table, vrr_table, vrr_type_table, provision_table, esticalhisto_table, calendar_table, admin)
    institutions_migration(fund, institution_table, country_table, position_table, admin)
    link_institution_loans(position_table)
    repayment_calendar_migration(fund, calendar_table, admin)
    provision_migration(calendar_table)
    gross_net_amount_migration()
    tranche_migration(position_table)
    inWatchList_InstitutionMigration()
    report_loans(position_table)
    report_institutions(institution_table)
    report_institutionsGroup(institution_group_table)
    report_repaymentCalendar(fund, calendar_table)
    puts"end Migration"
  end
end
