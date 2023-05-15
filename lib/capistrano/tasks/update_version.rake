# git_plugin = self

namespace :deploy do
  desc 'run some rake db task'
  task :update_version do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          deploy_date = Time.now.strftime('%F %T')
          command = "cd #{repo_path} && echo \"{\\\"revision\\\": \\\"$(git describe --tags --abbrev=0)\\\",\\\"build_at\\\": \\\"#{deploy_date}\\\"}\" > #{shared_path}/config/version.json"
          execute command
        end
      end
    end
  end
end
