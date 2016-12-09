require "rails_helper"

describe ArticleJob do
  describe "#perform" do
    context "with valid input" do
      it "creates an article" do
        params = attributes_for(:article)

        ArticleJob.new.perform("teh snappy", params)

        expect(Article.first).to have_attributes(params)
      end

      it "notifies the channel" do
        session_key = "iamasessionkey"
        article = instance_double(Article)
        notifier = instance_double(FrenchToast::Notifier, notify: nil)
        params = attributes_for(:article)
        allow(Article).to receive(:create!).and_return(article)
        allow(FrenchToast::Notifier).
          to receive(:new).
          with(session_key).
          and_return(notifier)

        ArticleJob.new.perform(session_key, params)

        expect(notifier).
          to have_received(:notify).with("Your article has been processed")
      end
    end
  end
end
