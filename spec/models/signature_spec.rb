require 'rails_helper'

RSpec.describe Signature, :type => :model do

  # it 'is not persisted'
  it 'has a valid factory' do
    expect(FactoryGirl.create(:signature)).to be_valid
  end

  it 'is invalid without name' do
    signature = FactoryGirl.create(:signature, name: nil)
    expect(signature).to_not be_valid
  end

  it 'is invalid without role' do
    signature = FactoryGirl.create(:signature, role: nil)
    expect(signature).to_not be_valid
  end

  it 'is invalid without email' do
    signature = FactoryGirl.create(:signature, email: nil)
    expect(signature).to_not be_valid
  end

  it 'has and asynchronous generator method' do
    signature = FactoryGirl.create(:signature)
    expect(signature).to respond_to :async_generate
  end

  it 'has a signature generator' do
    signature = FactoryGirl.create(:signature)
    expect(signature).to respond_to :generate
  end

end
