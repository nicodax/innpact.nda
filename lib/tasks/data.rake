namespace :demo do
  desc "Populate database with demo data"
  task populate: :environment do
    require 'factory_bot'

    Dir[Rails.root.join('spec', 'factories', '*.rb')].each { |f| require f }

    admin = FactoryBot.create(:administrator, {
      email: 'admin@innpact.com',
      password: 'password',
      password_confirmation: 'password',
      firstname: 'Admin',
      lastname: 'Innpact'
    })

    general_manager = FactoryBot.create(:general_manager, {
      password: 'password',
      password_confirmation: 'password'
    })

    3.times do
      fund = FactoryBot.create(:fund, {
        created_by: "#{admin.firstname} + #{admin.lastname}"
      }.merge(status: :active))

      investment_managers = FactoryBot.create_list(:investment_manager, 10, {
        password: 'password',
        password_confirmation: 'password'
      })

      im_group = FactoryBot.create(:im_group, fund: fund, user_ids: investment_managers.map(&:id))


      fund.countries.create([
                              { name: 'Albania', iso_code: 'AL', is_a_high_income_country: false,
                                created_by: "#{admin.firstname} + #{admin.lastname}" },
                              { name: 'Belgium', iso_code: 'BE', is_a_high_income_country: true,
                                created_by: "#{admin.firstname} + #{admin.lastname}" },
                              { name: 'Brunei Darussalam', iso_code: 'BN', is_a_high_income_country: true,
                                created_by: "#{admin.firstname} + #{admin.lastname}" },
                              { name: 'GreenLand', iso_code: 'GL', is_a_high_income_country: true,
                                created_by: "#{admin.firstname} + #{admin.lastname}" },
                              { name: 'Mexico', iso_code: 'MX', is_a_high_income_country: false,
                                created_by: "#{admin.firstname} + #{admin.lastname}" },
                              { name: 'New Zealand', iso_code: 'NZ', is_a_high_income_country: true,
                                created_by: "#{admin.firstname} + #{admin.lastname}" },
                              { name: 'Nigeria', iso_code: 'NG', is_a_high_income_country: false,
                                created_by: "#{admin.firstname} + #{admin.lastname}" },
                              { name: 'Pakistan', iso_code: 'PK', is_a_high_income_country: false,
                                created_by: "#{admin.firstname} + #{admin.lastname}" },
                              { name: 'Romania', iso_code: 'RO', is_a_high_income_country: false,
                                created_by: "#{admin.firstname} + #{admin.lastname}" },
                              { name: 'United States', iso_code: 'US', is_a_high_income_country: true,
                                created_by: "#{admin.firstname} + #{admin.lastname}" },
                              { name: 'Uruguay', iso_code: 'UY', is_a_high_income_country: true,
                                created_by: "#{admin.firstname} + #{admin.lastname}" },
                              { name: 'Uzbekistan', iso_code: 'UZ', is_a_high_income_country: false,
                                created_by: "#{admin.firstname} + #{admin.lastname}" },
                              { name: 'Yemen', iso_code: 'YE', is_a_high_income_country: false,
                                created_by: "#{admin.firstname} + #{admin.lastname}" }
                            ])

      fund.country_groups.create([
                                   { name: 'EU' },
                                   { name: 'CA' },
                                   { name: 'EAP' },
                                   { name: 'EECAU' },
                                   { name: 'LAC-SA' },
                                   { name: 'MENA' },
                                   { name: 'SA' },
                                   { name: 'SSA' },
                                   { name: 'USA' },
                                   { name: 'Worldwide' },
                                   { name: 'LAC-CA' }
                                 ])

      fund.loan_types.create([
                               { name: 'Add.Exp.' },
                               { name: 'New' },
                               { name: 'Renewal' },
                               { name: 'Renewal/ Add.Exp.' }
                             ])

      fund.bonds.create([
                          { name: 'Bond 1', description: FFaker::Lorem.sentence },
                          { name: 'Bond 2', description: FFaker::Lorem.sentence }
                        ])

      fund.statuses.create([
                             { name: 'Approval expired', user_id: admin.id },
                             { name: 'Approved', user_id: admin.id },
                             { name: 'Assign. Exp.', user_id: admin.id },
                             { name: 'Assigned', user_id: admin.id },
                             { name: 'Invested', user_id: admin.id },
                             { name: 'Matured', user_id: admin.id },
                             { name: 'New', user_id: admin.id },
                             { name: 'Not approved', user_id: admin.id },
                             { name: 'Not ratified', user_id: admin.id },
                             { name: 'Pending', user_id: admin.id },
                             { name: 'Released', user_id: admin.id },
                             { name: 'Released after approval', user_id: admin.id },
                             { name: 'Released before approval', user_id: admin.id }
                           ])

      FactoryBot.create_list(:institution, 3, fund: fund, im_group: im_group)
      FactoryBot.create_list(:interest_rate_type, 3, fund: fund)
      FactoryBot.create(:pool, fund: fund)

      %w[Bullet AMORTIZATION].each do |name|
        FactoryBot.create(:repayment_type, name: name, fund: fund)
      end

      %w[MFI Bank Leasing Faktoring Cooperative NGO 'Payroll leading' Other].each do |name|
        FactoryBot.create(:institution_type, name: name, fund: fund)
      end

      fund.currencies.create(short_name: 'CNY').currency_rates.create(rate:	7.093096, created_by: admin.full_name)
      fund.currencies.create(short_name: 'EUR').currency_rates.create(rate:	0.911369332421964,
                                                                      created_by: admin.full_name)
      fund.currencies.create(short_name: 'GHS').currency_rates.create(rate:	5.720027, created_by: admin.full_name)
      fund.currencies.create(short_name: 'HNL').currency_rates.create(rate:	24.748781, created_by: admin.full_name)
      fund.currencies.create(short_name: 'IDR').currency_rates.create(rate:	16_310.001367, created_by: admin.full_name)
      fund.currencies.create(short_name: 'INR').currency_rates.create(rate:	75.651265, created_by: admin.full_name)
      fund.currencies.create(short_name: 'KES').currency_rates.create(rate:	105.049989, created_by: admin.full_name)
      fund.currencies.create(short_name: 'KGS').currency_rates.create(rate:	80.810025, created_by: admin.full_name)
      fund.currencies.create(short_name: 'KZT').currency_rates.create(rate:	448.625063, created_by: admin.full_name)
      fund.currencies.create(short_name: 'MDL').currency_rates.create(rate:	18.300023, created_by: admin.full_name)
      fund.currencies.create(short_name: 'MMK').currency_rates.create(rate:	1398.979266, created_by: admin.full_name)
      fund.currencies.create(short_name: 'MNT').currency_rates.create(rate:	2775.000684, created_by: admin.full_name)
      fund.currencies.create(short_name: 'MXN').currency_rates.create(rate:	23.459239, created_by: admin.full_name)
      fund.currencies.create(short_name: 'NGN').currency_rates.create(rate:	381.500068, created_by: admin.full_name)
      fund.currencies.create(short_name: 'PEN').currency_rates.create(rate:	3.438551, created_by: admin.full_name)
      fund.currencies.create(short_name: 'PLN').currency_rates.create(rate:	4.15352, created_by: admin.full_name)
      fund.currencies.create(short_name: 'RUB').currency_rates.create(rate:	78.133789, created_by: admin.full_name)
      fund.currencies.create(short_name: 'THB').currency_rates.create(rate:	32.782502, created_by: admin.full_name)
      fund.currencies.create(short_name: 'TJS').currency_rates.create(rate:	10.21726, created_by: admin.full_name)
      fund.currencies.create(short_name: 'TZS').currency_rates.create(rate:	2315.000137, created_by: admin.full_name)
      fund.currencies.create(short_name: 'UZS').currency_rates.create(rate: 9554.220005, created_by: admin.full_name)
      fund.currencies.create(short_name: 'XOF').currency_rates.create(rate: 597.819139, created_by: admin.full_name)
      fund.currencies.create(short_name: 'ZMW').currency_rates.create(rate:	18.225017, created_by: admin.full_name)
      fund.currencies.create(short_name: 'USD').currency_rates.create(rate:	1, created_by: admin.full_name)
    end
  end
end
