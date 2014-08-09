require 'paratrooper'

namespace :deploy do
  desc 'Deploy app in staging environment'
  task :staging do
    deployment = Paratrooper::Deploy.new("jccf-myflix-staging", tag: 'staging')

    deployment.deploy
  end

  desc 'Deploy app in production environment'
  task :production do
    deployment = Paratrooper::Deploy.new("jccf-myflix") do |deploy|
      deploy.maintenance = true
      deploy.tag = 'production'
      deploy.match_tag = 'staging'
      deploy.add_callback(:before_setup) do |output|
        output.display("Totally going to turn off newrelic")
        system %Q[curl https://rpm.newrelic.com/accounts/"#{ENV['new_relic_account_id']}"/applications/"#{ENV['new_relic_application_id']}"/ping_targets/disable -X POST -H "X-Api-Key: #{ENV['newrelic_api_key']}"]
      end
      deploy.add_callback(:after_teardown) do |output|
        system %Q[curl https://rpm.newrelic.com/accounts/"#{ENV['new_relic_account_id']}"/applications/"#{ENV['new_relic_application_id']}"/ping_targets/enable -X POST -H "X-Api-Key: #{ENV['newrelic_api_key']}"]
        output.display("Aaaannnd we're back")
      end
    end

    deployment.deploy
  end
end
