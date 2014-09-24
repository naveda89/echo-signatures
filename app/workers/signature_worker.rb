class SignatureWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :default

  def perform(signature={})
    puts "Signature generator worker"
    puts signature.to_yaml
    sleep 10
  end

end