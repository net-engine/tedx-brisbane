require 'spec_helper'

describe Attendee do
  it { should validate_presence_of(:email_address) }
  it { should validate_uniqueness_of(:email_address) }
end
