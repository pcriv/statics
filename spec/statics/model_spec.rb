# frozen_string_literal: true

require "spec_helper"

RSpec.describe Statics::Model do
  let(:post) { Post.new(key: "post3", title: "Post", body: { en: "Hi!", "nl" => "Hoi!" }) }

  describe ".all" do
    subject { Post.all }

    it { is_expected.to be_a Statics::Collection }
  end

  describe ".where" do
    subject { Post.where(key: :post1) }

    it { is_expected.to be_a Statics::Collection }
    it { is_expected.to include(Post[:post1]) }
  end

  describe ".where_not" do
    subject { Post.where_not(key: :post1) }

    it { is_expected.to be_a Statics::Collection }
    it { is_expected.not_to include(Post[:post1]) }
  end

  describe ".keys" do
    subject { Post.keys }

    it { is_expected.to be_an Array }
    it { is_expected.to include(:post1, :post2) }
  end

  describe ".pluck" do
    subject { Post.pluck(:title) }

    it { is_expected.to be_an Array }
    it { is_expected.to include("Post 1", "Post 2") }
  end

  describe ".find_by" do
    subject { Post.find_by(title: "Post 1") }

    it { is_expected.to eq Post[:post1] }
  end

  describe "[]" do
    subject { Post[:post1] }

    context "when key is found" do
      it { is_expected.to be_a described_class }
    end

    context "when key is not found" do
      it { expect { Post[:not_a_key] }.to raise_error(Statics::KeyNotFoundError) }
    end
  end

  describe "#key" do
    subject { post.key }

    it { is_expected.to be_a Symbol }
  end

  describe "transtable attribute" do
    context "when no locale param is given" do
      subject { post.body }

      it { is_expected.to eq "Hi!" }
    end

    context "when locale param is given" do
      subject { post.body(locale: :nl) }

      it { is_expected.to eq "Hoi!" }
    end
  end

  describe "optional transtable attribute" do
    context "when attribute key is not present and no locale param is given" do
      subject { post.footer }

      it { is_expected.to eq(nil) }
    end

    context "when attribute key is not present and locale param is given" do
      subject { post.footer(locale: :nl) }

      it { is_expected.to eq(nil) }
    end

    context "when attribute key is present" do
      subject { post.footer }

      let(:post) { Post[:post3] }

      it { is_expected.to eq("Good evening") }
    end
  end
end
