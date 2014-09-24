class Signature
  include ActiveModel::Model
  include ActiveModel::Dirty
  include ActiveModel::Validations
  include ActiveModel::Serializers
  extend ActiveModel::Callbacks

  define_model_callbacks :save

  attr_accessor :name, :role, :email, :telephone, :web

  validates_presence_of :name, :role, :email

  after_save :generate

  def save
    if valid?
      # do persistence work
      changes_applied
      run_callbacks(:save) { true }
    else
      false
    end
  end

  def persisted?
    false
  end

  def generate
    SignatureWorker.perform_async(self.as_json)
  end

end