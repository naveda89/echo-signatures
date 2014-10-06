class SignaturesController < InheritedResources::Base
  include Tubesock::Hijack

  respond_to :json, :html

  before_filter :set_pssid

  def generator

    # WebSocket events handler
    hijack do |tubesock|

      # Websocket connection open
      tubesock.onopen do |data|
        tubesock.send_data 'Connected to ws'.to_json
      end

      # Websocket messages receiver
      tubesock.onmessage do |data|

        # Subscribes to redis :pssid channel
        # when client wants to wait for a signature
        if data == 'wait'
          redis.subscribe(session[:pssid]) do |on|
            on.message do |channel, message|
              # Pipe message from SignatureGenerator worker to client
              tubesock.send_data message
              # Close PubSub connection
              ps_unsuscribe
            end
          end
        end

      end

    end

  end

private

  # Request a redis connection from Sidekiq connection pool
  def redis
    @redis ||= Sidekiq.redis { |redis| redis }
  end

  # Set Redis PubSub channel identifier
  def set_pssid
    session[:pssid] ||= SecureRandom.hex(10)
    params.deep_merge!(signature: { pssid: session[:pssid] })
  end

  # Unsuscribe from PubSub channel
  def ps_unsuscribe
    redis.unsubscribe(session[:pssid])
    session[:pssid] = nil
  end

end
