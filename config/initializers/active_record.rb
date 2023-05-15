# Monkey patch to prevent DB tasks to be run automatically in test environment when
# run in development environment (see https://github.com/rails/rails/issues/27299) .
# This code should be updated with each Rails update
if Rails.configuration.x.disable_rails_autorun_test_db_task
  module ActiveRecord
    module Tasks
      module DatabaseTasks

        private

        def each_current_configuration(environment, spec_name = nil)
          environments = [environment]
          environments.each do |env|
            ActiveRecord::Base.configurations.configs_for(env_name: env).each do |db_config|
              next if spec_name && spec_name != db_config.spec_name

              yield db_config.config, db_config.spec_name, env
            end
          end
        end
      end
    end
  end
end