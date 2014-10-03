class SignaturesController < InheritedResources::Base
  include Tubesock::Hijack

  respond_to :json, :html

  def generator
    hijack do |tubesock|
      tubesock.onopen do
        puts "########## onopen"
        tubesock.send_data "Hello, friend"
      end

      tubesock.onmessage do |data|
        puts "########## onmessage"
        tubesock.send_data "You said: #{data}"
      end
    end
  end

end
