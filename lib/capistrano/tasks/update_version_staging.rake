# git_plugin = self
namespace :deploy do
  desc 'run some rake db task'
  task :update_version_staging do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:stage) do
          deploy_date = Time.now.strftime('%F %T')
          command = "cd #{repo_path} && echo \"{\\\"revision\\\": \\\"$(git name-rev --name-only #{fetch(:current_revision)}) #{fetch(:current_revision)}\\\",\\\"build_at\\\": \\\"#{deploy_date}\\\"}\" > #{shared_path}/config/version.json"
          execute command
        end
      end
    end
  end
end
