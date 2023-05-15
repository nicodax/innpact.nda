require 'ffaker'
require 'factory_bot'

module FactoryBot::SyntaxSugar
  def resources_path(*parts)
    Pathname(File.join(File.realpath(__FILE__), '..', '..', '..', 'resources', *parts)).expand_path
  end

  def resources_file(*parts)
    File.new resources_path(*parts)
  end
end
FactoryBot::SyntaxRunner.include FactoryBot::SyntaxSugar

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include FactoryBot::SyntaxSugar

  config.before(:suite) do
    FactoryBot.factories.clear
    FactoryBot.find_definitions
  end
end
