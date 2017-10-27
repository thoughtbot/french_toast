require "rails_helper"

RSpec.describe FrenchToast::PayloadProcessor do
  describe "#initialize" do
    it "does not require locals to be specified" do
      expect { described_class.new(partial_name: "foobar") }.not_to raise_error
    end
  end

  describe "#process" do
    it "renders the partial using the locals with ApplicationController" do
      result = Random.new.rand.to_s
      allow(ApplicationController).to receive(:render).and_return(result)

      processor = described_class.new(
        partial_name: "my_partial",
        locals: { one: 1, two: 2 },
      )

      processed_payload = processor.process

      expect(processed_payload).to match(result)
      expect(ApplicationController).to have_received(:render).with(
        partial: "french_toast/my_partial",
        locals: { one: 1, two: 2 },
      )
    end
  end
end
