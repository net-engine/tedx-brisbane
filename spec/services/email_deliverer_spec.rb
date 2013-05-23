require 'spec_helper'
describe EmailDeliverer do
  let(:email) { create(:email) }

  describe '.post' do
    it "responds to .post" do
      EmailDeliverer.post "http://google.com"
    end
  end

  describe '.deliver' do
    it "creates an instance of EmailDeliverer" do
      deliverer = double('deliverer').as_null_object

      EmailDeliverer.stub(:new).and_return(deliverer)
      EmailDeliverer.should_receive(:new).with(email.id)

      EmailDeliverer.deliver(email.id)
    end
  end



  describe '#deliver' do
    it "calls POST on the EmailDeliverer class" do
      EmailDeliverer.stub(:post)
      EmailDeliverer.should_receive(:post)

      EmailDeliverer.new(email.id).deliver
    end
  end
end

