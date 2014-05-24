#to amend!

class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    puts 'Doing hard work'
  end
end