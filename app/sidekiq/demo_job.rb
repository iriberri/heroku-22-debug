class DemoJob
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform
    logger.info 'Running the Demo Job!!!!'
  end
end
