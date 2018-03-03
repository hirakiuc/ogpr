require 'spec_helper'

RSpec.describe Ogpr::Parser do
  describe 'self.parse' do
    context 'with html which contains twitter/og tags' do
      let(:html) { htmlContent('page.html') }

      it 'should return Ogpr::Result' do
        result = Ogpr::Parser.parse(html)
        expect(result).to be_an_instance_of(Ogpr::Result)

        expect(result.meta).to eq({
          'og:site_name' => 'sample page',
          'og:title' => 'sample title',
          'og:description' => 'sample page description',
          'og:url' => 'https://example.com/page.html',
          'og:image' => 'https://example.com/image.png',
          'og:type' => 'article',
          'twitter:card' => 'summary_large_image',
          'twitter:site' => '@twitter',
          'twitter:creator' => '@twitter'
        })

        expect(result.open_graph).to be_an_instance_of(Ogpr::Model::OpenGraph)
        expect(result.open_graph.meta).to eq({
          'og:site_name' => 'sample page',
          'og:title' => 'sample title',
          'og:description' => 'sample page description',
          'og:url' => 'https://example.com/page.html',
          'og:image' => 'https://example.com/image.png',
          'og:type' => 'article',

        })

        expect(result.twitter_card).to be_an_instance_of(Ogpr::Model::TwitterCard)
        expect(result.twitter_card.meta).to eq({
          'twitter:card' => 'summary_large_image',
          'twitter:site' => '@twitter',
          'twitter:creator' => '@twitter'
        })
      end
    end
  end
end
