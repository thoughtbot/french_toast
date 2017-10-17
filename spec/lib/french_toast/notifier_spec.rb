require "rails_helper"

RSpec.describe FrenchToast::Notifier do
  describe "#notify" do
    it "broadcasts to ActionCable using the session key as the channel and the payload as the message" do
      session_key = "a user's session key"
      payload = "a payload to send"
      allow(ApplicationController).to receive(:render).and_return(payload)
      allow(ActionCable.server).to receive(:broadcast)

      described_class.new(session_key).notify(payload)

      expect(ActionCable.server).
        to have_received(:broadcast).with(session_key, payload)
    end
  end
end
