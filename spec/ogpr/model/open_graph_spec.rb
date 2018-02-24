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

  context 'common attributes' do
    context 'when with meta data' do
      let(:meta) {
        {
          'og:title' => 'sample site',
          'og:description' => 'sample site description',
          'og:url' => 'https://example.com/path/to/page',
          'og:image' => 'https://example.com/path/to/image.png'
        }
      }

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

  describe '[] method' do
    let(:meta) {
      {
        'og:title' => 'sample site',
        'og:description' => 'sample site description',
        'og:url' => 'https://example.com/path/to/page',
        'og:image:url' => 'https://example.com/path/to/image.png',
        'og:image:width' => 200,
        'og:image:height' => 300
      }
    }

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
end
