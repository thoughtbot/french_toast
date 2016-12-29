require "rails_helper"

describe ArticleJob do
  describe "#perform" do
    context "with valid input" do
      it "creates an article" do
        stub_notifier!

        ArticleJob.new.perform(session_key, article_params)

        expect(Article.first).to have_attributes(article_params)
      end

      it "notifies the channel" do
        notifier = stub_notifier!
        article = instance_double(Article)
        allow(Article).to receive(:create!).with(article_params).and_return(article)

        ArticleJob.new.perform(session_key, article_params)

        expect(notifier).
          to have_received(:notify).with(:article_created)
      end

      def stub_notifier!
        instance_double(FrenchToast::Notifier, notify: nil).tap do |notifier|
          allow(FrenchToast::Notifier).to receive(:new).and_return(notifier)
        end
      end

      let(:article_params) { attributes_for(:article) }
      let(:session_key) { "iamasessionkey" }
    end
  end
end
