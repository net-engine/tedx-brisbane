class EmailDeliveryWorker
  include Sidekiq::Worker

  def perform(id)
    EmailDeliverer.deliver(id)
  end
end
