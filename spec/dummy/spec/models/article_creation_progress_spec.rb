require 'rails_helper'

describe ArticleCreationProgress do
  describe "#progress" do
    it "returns a hash" do
      article = spy("Article")

      result = ArticleCreationProgress.new(article).progress

      expect(result).to be_a(Hash)
    end
    
    context "when the title is blank" do
      it "indicates that the author is blank" do
        article = spy("Article", author: "")

        result = ArticleCreationProgress.new(article).progress

        expect(result[:author]).to eq(false)
      end
    end

    context "when the author is present" do
      it "indicates that the author is present" do
        article = spy("Article", author: "Great Expectations")

        result = ArticleCreationProgress.new(article).progress

        expect(result[:author]).to eq(true)
      end
    end
    
    context "when the title is blank" do
      it "indicates that the title is blank" do
        article = spy("Article", title: "")

        result = ArticleCreationProgress.new(article).progress

        expect(result[:title]).to eq(false)
      end
    end

    context "when the title is present" do
      it "indicates that the title is present" do
        article = spy("Article", title: "Great Expectations")

        result = ArticleCreationProgress.new(article).progress

        expect(result[:title]).to eq(true)
      end
    end

    context "when the body is blank" do
      it "indicates that the body is blank" do
        article = spy("Article", body: "")

        result = ArticleCreationProgress.new(article).progress

        expect(result[:body]).to eq(false)
      end
    end

    context "when the body is present" do
      it "indicates that the body is present" do
        article = spy("Article", body: "Some really great Expectations")

        result = ArticleCreationProgress.new(article).progress

        expect(result[:body]).to eq(true)
      end
    end


    context "when the tags are blank" do
      it "indicates that the tags are blank" do
        article = spy("Article", tags: "")

        result = ArticleCreationProgress.new(article).progress

        expect(result[:tags]).to eq(false)
      end
    end

    context "when the tags are present" do
      it "indicates that the tags are present" do
        article = spy("Article", tags: "Computers News")

        result = ArticleCreationProgress.new(article).progress

        expect(result[:tags]).to eq(true)
      end
    end
  end
end
