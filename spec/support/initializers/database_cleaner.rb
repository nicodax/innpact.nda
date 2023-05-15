require 'database_cleaner'

cleaner = DatabaseCleaner[:active_record, { connection: :test }]

RSpec.configure do |config|
  config.before(:suite) do
    cleaner.clean_with :truncation
  end

  config.before(:each) do
    cleaner.strategy = :truncation

    cleaner.start
  end

  config.after(:each) do
    cleaner.clean
  end
end
