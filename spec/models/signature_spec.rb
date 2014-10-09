require 'rails_helper'

RSpec.describe Signature, :type => :model do

  # it 'is not persisted'
  it 'has a valid factory' do
    expect(FactoryGirl.build(:signature)).to be_valid
  end

  it 'is invalid without name' do
    signature = FactoryGirl.build(:signature, name: nil)
    expect(signature).to_not be_valid
  end

  it 'is invalid without role' do
    signature = FactoryGirl.build(:signature, role: nil)
    expect(signature).to_not be_valid
  end

  it 'is invalid without email' do
    signature = FactoryGirl.build(:signature, email: nil)
    expect(signature).to_not be_valid
  end

  it 'has an asynchronous generator method' do
    signature = FactoryGirl.build(:signature)
    expect(signature).to respond_to :async_generate
  end

  it 'has a signature generator' do
    signature = FactoryGirl.build(:signature)
    expect(signature).to respond_to :generate
  end

end
