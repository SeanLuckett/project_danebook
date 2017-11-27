require 'rails_helper'

RSpec.describe Address, type: :model do
  it 'is valid with street1, city, state, and postcode' do
    expect(build(:address)).to be_valid
  end

  it 'is invalid without street1' do
    addy = build :address, street1: nil
    addy.valid?
    expect(addy.errors[:street1]).to include "can't be blank"
  end

  it 'is invalid without city' do
    addy = build :address, city: nil
    addy.valid?
    expect(addy.errors[:city]).to include "can't be blank"
  end

  it 'is invalid without state' do
    addy = build :address, state: nil
    addy.valid?
    expect(addy.errors[:state]).to include "can't be blank"
  end

  it 'is invalid without postcode' do
    addy = build :address, postcode: nil
    addy.valid?
    expect(addy.errors[:postcode]).to include "can't be blank"
  end
end
