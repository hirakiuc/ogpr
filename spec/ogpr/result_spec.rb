require 'spec_helper'

RSpec.describe Ogpr::Result do
  let(:og_tags) do
    {
      "og:site_name"=>"sample site",
      "og:title"=> "sample site title",
      "og:description"=> "sample site description",
      "og:url"=>"https://example.com/page.html",
      "og:image"=> "https://example.com/image.png",
      "og:type"=>"article",
    }
  end

  let(:twitter_tags) do
    {
      "twitter:title" => "sample site title",
      "twitter:description" => "sample site description",
      "twitter:card"=>"summary_large_image",
      "twitter:image"=> "https://example.com/image.png",
      "twitter:site"=>"@twitter",
      "twitter:creator"=>"@twitter"
    }
  end

  let(:both_tags) do
    (og_tags.dup).merge(twitter_tags.dup)
  end

  let(:both_result) do
    Ogpr::Result.new(both_tags)
  end

  let(:og_result) do
    Ogpr::Result.new(og_tags)
  end

  let(:twitter_result) do
    Ogpr::Result.new(twitter_tags)
  end

  let(:empty_result) do
    Ogpr::Result.new({})
  end

  describe '#initialize' do
    context 'when meta contains no og/twitter tags' do
      it 'should have only meta' do
        expect(empty_result).to be_an_instance_of(Ogpr::Result)
        expect(empty_result.open_graph).to be_nil
        expect(empty_result.twitter_card).to be_nil
        expect(empty_result.meta).to eq({})
      end
    end

    context 'when meta contains only og tags' do
      it 'should have open_graph and meta' do
        expect(og_result).to be_an_instance_of(Ogpr::Result)
        expect(og_result.open_graph).to be_an_instance_of(Ogpr::Model::OpenGraph)
        expect(og_result.twitter_card).to be_nil
        expect(og_result.meta).to eq(og_tags)
      end
    end

    context 'when meta contains only twitter tags' do
      it 'should have twitte_card and meta' do
        expect(twitter_result).to be_an_instance_of(Ogpr::Result)
        expect(twitter_result.open_graph).to be_nil
        expect(twitter_result.twitter_card).to be_an_instance_of(Ogpr::Model::TwitterCard)
        expect(twitter_result.meta).to eq(twitter_tags)
      end
    end

    context 'when meta contains both of og/twitter tags' do
      it 'should have open_graph, twitter_card and meta' do
        expect(both_result).to be_an_instance_of(Ogpr::Result)
        expect(both_result.open_graph).to be_an_instance_of(Ogpr::Model::OpenGraph)
        expect(both_result.twitter_card).to be_an_instance_of(Ogpr::Model::TwitterCard)
        expect(both_result.meta).to eq(both_tags)
      end
    end
  end

  describe '#exist?' do
    context 'when meta contains no og/twitter tags' do
      it 'should return true' do
        expect(both_result.exist?).to be_truthy
      end
    end

    context 'when meta contains only og tags' do
      it 'should return true' do
        expect(og_result.exist?).to be_truthy
      end
    end

    context 'when meta contains only twitter tags' do
      it 'should return true' do
        expect(twitter_result.exist?).to be_truthy
      end
    end

    context 'when meta contains both of og/twitter tags' do
      it 'should return false' do
        expect(both_result.exist?).to be_truthy
      end
    end
  end

  describe '#open_graph?' do
    context 'when meta contains no og/twitter tags' do
      it 'should return false' do
        expect(empty_result.open_graph?).to be_falsey
      end
    end

    context 'when meta contains only og tags' do
      it 'should return true' do
        expect(og_result.open_graph?).to be_truthy
      end
    end

    context 'when meta contains only twitter tags' do
      it 'should return false' do
        expect(twitter_result.open_graph?).to be_falsey
      end
    end

    context 'when meta contains both of og/twitter tags' do
      it 'should return true' do
        expect(both_result.open_graph?).to be_truthy
      end
    end
  end

  describe '#twitter_card?' do
    context 'when meta contains no og/twitter tags' do
      it 'should return false' do
        expect(empty_result.twitter_card?).to be_falsey
      end
    end

    context 'when meta contains only og tags' do
      it 'should return false' do
        expect(og_result.twitter_card?).to be_falsey
      end
    end

    context 'when meta contains only twitter tags' do
      it 'should return true' do
        expect(twitter_result.twitter_card?).to be_truthy
      end
    end

    context 'when meta contains both of og/twitter tags' do
      it 'should return true' do
        expect(both_result.twitter_card?).to be_truthy
      end
    end
  end

  describe 'common attributes' do
    context 'when meta contains no og/twitter tags' do
      it 'should nil' do
        expect(empty_result.title).to be_nil
        expect(empty_result.description).to be_nil
        expect(empty_result.url).to be_nil
        expect(empty_result.image).to be_nil
      end
    end

    context 'when meta contains only og tags' do
      it 'should return og values' do
        expect(og_result.title).to eq('sample site title')
        expect(og_result.description).to eq('sample site description')
        expect(og_result.url).to eq('https://example.com/page.html')
        expect(og_result.image).to eq('https://example.com/image.png')
      end
    end

    context 'when meta contains only twitter tags' do
      it 'should return twitter values' do
        expect(twitter_result.title).to eq('sample site title')
        expect(twitter_result.description).to eq('sample site description')
        expect(twitter_result.url).to be_nil
        expect(twitter_result.image).to eq('https://example.com/image.png')
      end
    end

    context 'when meta contains both of og/twitter tags' do
      it 'should return og values' do
        expect(both_result.title).to eq('sample site title')
        expect(both_result.description).to eq('sample site description')
        expect(both_result.url).to eq('https://example.com/page.html')
        expect(both_result.image).to eq('https://example.com/image.png')
      end
    end
  end
end
