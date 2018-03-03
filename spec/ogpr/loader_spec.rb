require 'spec_helper'

RSpec.describe Ogpr::Loader do
  describe 'self.load' do
    context 'with hash which contains twitter/og tags' do
      let(:hash) do
        {
          'og:site_name' => 'sample page',
          'og:title' => 'sample title',
          'og:description' => 'sample page description',
          'og:url' => 'https://example.com/page.html',
          'og:image' => 'https://example.com/image.png',
          'og:type' => 'article',
          'twitter:card' => 'summary_large_image',
          'twitter:site' => '@twitter',
          'twitter:creator' => '@twitter'
        }
      end

      it 'should return Ogpr::Result' do
        result = Ogpr::Loader.load(hash)
        expect(result).to be_an_instance_of(Ogpr::Result)

        expect(result.meta).to eq(hash)

        expect(result.open_graph).to be_an_instance_of(Ogpr::Model::OpenGraph)
        expect(result.open_graph.meta).to eq(
          hash.select {|k, _| k =~ /^og/}
        )

        expect(result.twitter_card).to be_an_instance_of(Ogpr::Model::TwitterCard)
        expect(result.twitter_card.meta).to eq(
          hash.select { |k, _| k =~ /^twitter/ }
        )
      end
    end
  end
end
