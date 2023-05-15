namespace :trade_and_services do
  desc 'Merge trade and services into trade_and_services'
  task merge: :environment do
    institutions = Institution.where.not(trade: nil).or(Institution.where.not(services: nil))
    institutions.find_each do |institution|
      institution.update!(trade_and_services: [institution.trade, institution.services].compact.sum)
    end
  end
end
