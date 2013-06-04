require 'spec_helper'

describe Payment do
  it { should validate_presence_of(:attendee_id) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:transaction_id) }
  it { should validate_presence_of(:masked_number) }
  it { should validate_presence_of(:card_type) }
end
