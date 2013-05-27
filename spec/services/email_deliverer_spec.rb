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
      url = "https://mandrillapp.com/api/1.0/messages/send.json"
      email.stub(:to_json).and_return("the_json")
      Email.stub(:find).with(email.id).and_return(email)

      options = {
        body: "the_json",
        headers: { 'Accept' => 'application/json',
                   'Content-type' => 'application/json' }
      }

      EmailDeliverer.stub(:post)
      EmailDeliverer.should_receive(:post).with(url, options)

      EmailDeliverer.new(email.id).deliver
    end
  end
end

