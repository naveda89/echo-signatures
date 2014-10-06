require 'RMagick'
require 'aws-sdk'

module SignatureGenerator
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def generate(data={})
      data.except!('errors', 'validation_context')
      data.except!('changed_attributes', 'previously_changed')

      signature = Signature.new(data)
      signature.generate
    end
  end

  #
  # Generates signature image and saves it
  def generate
    # Trigger all signature image generators
    process
    # Notify with a URL to the waiting client
    notify_client save_signature
  end

  #
  # Define image sizes depending on enterprise
  def signature_size
    sizes = {'tenzing' => { w: 900, h: 200 },
             'default' => { w: 650, h: 200 }}
    @signature_size ||= sizes[enterprise] || sizes['default']
  end

  #
  # Generates image with different sizes and colors depending
  # on enterprise and returns a Magick::Image object
  def image
    sizes = signature_size
    @image ||= Magick::Image.new(sizes[:w], sizes[:h]) {
      self.background_color = 'white'
    }
  end

  #
  # Apply image processing
  def process
    draw_topline
    draw_logos
    draw_texts
  end

  #
  # Draw corporative top line
  def draw_topline
    tline = Magick::Draw.new
    tline.stroke = '#1F3462'
    tline.fill = '#1F3462'
    tline.rectangle 0, 0, signature_size[:w], 4
    tline.draw(image)
  end

  #
  # Draw enterprise logos depending on each case
  def draw_logos
    draw_logo(enterprise, startX = 440)
    draw_logo('urbegi', startX + 250) if enterprise == 'tenzing'
  end


  # Draw the enterprise's logo into the Signature image by using Magick::Draw API
  #
  # ==== Examples
  #
  #   draw_logo('tenzing', 440)
  def draw_logo(enterprise, xPosition)
    # Enterprise logo
    logo = Magick::Image.read(logo_path(enterprise)).first
    image.composite!(logo, xPosition, 40, Magick::OverCompositeOp)
    # Vertical separator
    logo = Magick::Image.read(vseparator_path).first
    image.composite!(logo, xPosition - 40, 20, Magick::OverCompositeOp)
  end

  # Draw signature texts in the correct place inside the signature image
  def draw_texts
    lineTop = 40
    write_text(lineTop += 20, name, '#1F3462', 20, 0) # Name
    write_text(lineTop += 20, role, '#A8A8A8', 16)    # Role

    lineTop += 20
    write_text(lineTop += 20, email,      '#A8A8A8', 16) # Email
    write_text(lineTop += 20, telephone,  '#A8A8A8', 16) # Telephone
    write_text(lineTop += 20, web,        '#A8A8A8', 16) # Webpage
  end

  # Write text into the Signature image by using Magick::Draw API
  # ==== Examples
  #
  #   write_text(20, 'First name & etc', '#1F3462', 20, 0)
  #   write_text(40, 'http://naveda.me', '#A8A8A8', 16)
  def write_text(yPosition, text, color, size, kerning=-0.5)
    @draw ||= Magick::Draw.new
    @draw.font = font_path
    @draw.text_antialias = true
    @draw.stroke = 'transparent'
    @draw.kerning = kerning

    @draw.annotate(image, 0, 0, 40, yPosition, text) {
      self.fill = color
      self.pointsize = size
    }
  end

  # Retrieve the vertical separator path inside the current project
  def vseparator_path
    @vseparator_path ||= "#{Rails.root}/app/assets/images/signatures/separator.png"
  end

  # Retrieve the enterprise's logo path inside the current project
  def logo_path(enterprise)
    "#{Rails.root}/app/assets/images/logos/#{enterprise}.png"
  end

  # Retrieve the text writer font path inside the current project
  def font_path
    @font_path ||= "#{Rails.root}/app/assets/fonts/HelveticaLt.ttf"
  end

  # Saves the image in a temporal path and upload the signature to AWS S3
  def save_signature
    image.write(file_path = "#{Rails.root}/tmp/#{SecureRandom.hex(10)}.png")
    return upload_signature(file_path)
  end

  def upload_signature(file_path)
    s3 = AWS::S3.new
    bucket = s3.buckets[AWS_S3_BUCKET]

    # Upload file to AWS_S3_BUCKET
    key = File.basename("#{name.parameterize}_#{SecureRandom.hex(10)}")
    bucket.objects[key].write(file: file_path, acl: :public_read)

    # Uploaded file remote URL
    "https://s3.amazonaws.com/#{AWS_S3_BUCKET}/#{key}"
  end

  # Notify through redis pubsub
  def notify_client(url)
    Sidekiq.redis { |redis|
      redis.publish(pssid, { url: url }.to_json )
    }
  end

end