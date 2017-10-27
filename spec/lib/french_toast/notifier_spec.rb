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

    it "accepts locals hash" do
      session_key = "a user's session key"
      payload = "a payload to send"
      allow(ApplicationController).to receive(:render).and_return(payload)
      allow(ActionCable.server).to receive(:broadcast)

      described_class.new(session_key).
        notify(:partial_name, locals: { foo: :bar })

      expect(ApplicationController).to have_received(:render).with(
        partial: "french_toast/partial_name",
        locals: { foo: :bar },
      )
      expect(ActionCable.server).
        to have_received(:broadcast).with(session_key, payload)
    end

    context "when a user is connected via ActionCable" do
      it "deletes the session's LastNotification" do
        session_key = "a user's session key"
        payload = "a payload to send"
        fake_redis = instance_double(Redis)
        allow(Redis).to receive(:new).and_return(fake_redis)
        allow(fake_redis).to receive(:pubsub).
          with("channels", "action_cable/*").
          and_return([
            "action_cable/#{session_key}",
            "action_cable/asdfasdfasdgasdga",
          ])
        allow(ApplicationController).to receive(:render).and_return(payload)
        allow(ActionCable.server).to receive(:broadcast)

        described_class.new(session_key).
          notify(:partial_name, locals: { foo: :bar })

        expect(FrenchToast::LastNotification.where(session: session_key)).
          to be_empty
      end
    end

    context "when users is not connected via ActionCable" do
      it "does not delete the session's LastNotification" do
        session_key = "a user's session key"
        payload = "a payload to send"
        allow(ApplicationController).to receive(:render).and_return(payload)
        allow(ActionCable.server).to receive(:broadcast)

        described_class.new(session_key).
          notify(:partial_name, locals: { foo: :bar })

        expect(FrenchToast::LastNotification.find_by(session: session_key)).
          to be_present
      end
    end

    def subscribe_to_action_cable_channels(channel_names)
      redis_channel_keys = channel_names.map do |channel_name|
        "action_cable/#{channel_name}"
      end
      fake_redis = instance_double(Redis)
      allow(Redis).to receive(:new).and_return(fake_redis)
      allow(fake_redis).
        to receive(:pubsub).
        with("channels", "action_cable/*").
        and_return(redis_channel_keys)
    end
  end
end
