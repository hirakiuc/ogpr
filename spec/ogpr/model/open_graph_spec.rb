require 'spec_helper'

RSpec.describe Ogpr::Model::OpenGraph do
  let(:model) { Ogpr::Model::OpenGraph.new(meta) }

  describe 'initialize' do
    it 'should create instance' do
      h = {'og:title' => 'sample title'}
      m = Ogpr::Model::OpenGraph.new(h)

      expect(m.meta).to eq(h)
    end
  end

  describe 'self.create' do
    context 'with meta which has no og tags' do
      let(:meta) do
        {
          'twitter:card' => 'summary_large_image',
          'twitter:site' => '@nytimes'
        }
      end

      it 'should return nil' do
        expect(Ogpr::Model::OpenGraph.create(meta)).to be_nil
      end
    end

    context 'with meta which has some og tags' do
      let(:meta) do
        {
          'og:type' => 'website',
          'og:title' => 'sample site',
          'og:description' => 'sample site description',
          'og:url' => 'https://example.com/path/to/page',
          'og:image' => 'https://example.com/path/to/image.png'
        }
      end

      it 'should return an instance of the OpenGraph model' do
        m = Ogpr::Model::OpenGraph.create(meta)
        expect(m).to be_an_instance_of(Ogpr::Model::OpenGraph)
        expect(m.meta).to eq(meta)
      end
    end
  end

  context 'common attributes' do
    context 'when with meta data' do
      let(:meta) do
        {
          'og:type' => 'website',
          'og:title' => 'sample site',
          'og:description' => 'sample site description',
          'og:url' => 'https://example.com/path/to/page',
          'og:image' => 'https://example.com/path/to/image.png'
        }
      end

      describe '#type' do
        it 'should return og:type value' do
          expect(model.type).to eq('website')
        end
      end

      describe '#title' do
        it 'should return og:title value' do
          expect(model.title).to eq('sample site')
        end
      end

      describe '#description' do
        it 'should return og:description value' do
          expect(model.description).to eq('sample site description')
        end
      end

      describe '#url' do
        it 'should return og:url value' do
          expect(model.url).to eq('https://example.com/path/to/page')
        end
      end

      describe '#image' do
        it 'should return og:image value' do
          expect(model.image).to eq('https://example.com/path/to/image.png')
        end
      end
    end

    context 'when with empty meta data' do
      let(:meta) { {} }

      describe '#type' do
        it 'should return og:type value' do
          expect(model.type).to be_nil
        end
      end

      describe '#title' do
        it 'should return nil' do
          expect(model.title).to be_nil
        end
      end

      describe '#description' do
        it 'should return nil' do
          expect(model.description).to be_nil
        end
      end

      describe '#url' do
        it 'should return nil' do
          expect(model.url).to be_nil
        end
      end

      describe '#image' do
        it 'should return nil' do
          expect(model.image).to be_nil
        end
      end
    end
  end

  describe '#[]' do
    let(:meta) do
      {
        'og:title' => 'sample site',
        'og:description' => 'sample site description',
        'og:url' => 'https://example.com/path/to/page',
        'og:image:url' => 'https://example.com/path/to/image.png',
        'og:image:width' => 200,
        'og:image:height' => 300
      }
    end

    context 'when the property exists' do
      it 'should return the meta property value' do
        expect(model['title']).to eq('sample site')
        expect(model['image:url']).to eq('https://example.com/path/to/image.png')
        expect(model['image:width']).to eq(200)
      end
    end

    context 'when the property does not exist' do
      it 'should return nil' do
        expect(model['un-existed-prop']).to be_nil
      end
    end
  end

  describe '#keys' do
    let(:meta) do
      {
        'og:title' => 'sample site',
        'og:description' => 'sample site description',
        'og:url' => 'https://example.com/path/to/page',
        'og:image:url' => 'https://example.com/path/to/image.png',
        'og:image:width' => 200,
        'og:image:height' => 300
      }
    end

    it 'should return keys' do
      expect(model.keys).to match_array([
       'description', 'image:url', 'image:width', 'image:height', 'title', 'url'
      ])
    end
  end

  describe '#each_key' do
    let(:meta) do
      {
        'og:title' => 'sample site',
        'og:description' => 'sample site description',
        'og:url' => 'https://example.com/path/to/page',
        'og:image:url' => 'https://example.com/path/to/image.png',
        'og:image:width' => 200,
        'og:image:height' => 300
      }
    end

    it 'should call the block' do
      expect { |b| model.each_key(&b) }.to yield_successive_args(
        'description', 'image:height', 'image:url', 'image:width', 'title', 'url'
      )
    end
  end

  describe '#each_pair' do
    let(:meta) do
      {
        'og:title' => 'sample site',
        'og:description' => 'sample site description',
        'og:url' => 'https://example.com/path/to/page',
        'og:image:url' => 'https://example.com/path/to/image.png',
        'og:image:width' => 200,
        'og:image:height' => 300
      }
    end

    it 'should call the block' do
      expect { |b| model.each_pair(&b) }.to yield_successive_args(
        ['description', 'sample site description'],
        ['image:height', 300],
        ['image:url', 'https://example.com/path/to/image.png'],
        ['image:width', 200],
        ['title', 'sample site'],
        ['url', 'https://example.com/path/to/page']
      )
    end
  end

  describe '#to_s' do
    let(:meta) do
      {
        'og:title' => 'sample site',
        'og:description' => 'sample site description',
        'og:url' => 'https://example.com/path/to/page',
        'og:image:url' => 'https://example.com/path/to/image.png',
        'og:image:width' => 200,
        'og:image:height' => 300
      }
    end

    it 'should return the string' do
      expect(model.to_s).to eq(model.meta.to_s)
    end
  end
end
