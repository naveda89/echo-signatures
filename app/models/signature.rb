class Signature
  include ActiveModel::Model
  include ActiveModel::Dirty
  include ActiveModel::Validations
  include ActiveModel::Serializers
  extend ActiveModel::Callbacks

  include SignatureGenerator

  define_model_callbacks :save

  attr_accessor :name, :role, :email, :telephone, :web, :enterprise
  attr_accessor :pssid

  validates_presence_of :name, :role, :email

  before_save :default_values
  after_save :async_generate

  def save
    if valid?
      # do persistence work
      changes_applied
      run_callbacks(:save) { true }
    else
      false
    end
  end

  def save!
    save
  end

  def persisted?
    false
  end

  def default_values
    self.web = self.web.presence || 'http://www.urbegi.com'
    self.telephone = self.telephone.presence || 'Tel. 94 680 19 34'
    self.enterprise = self.enterprise.presence || 'urbegi'
  end

  def async_generate
    SignatureWorker.perform_async(self.as_json)
  end

end