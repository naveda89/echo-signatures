class SignatureWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :default

  def perform(data={})
    Signature.generate(data)
  end

end