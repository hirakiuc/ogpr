require 'spec_helper'

RSpec.describe Ogpr::Model::TwitterCard do
  let(:model) { Ogpr::Model::TwitterCard.new(meta) }

  describe 'initialize' do
    it 'should create instance' do
      h = { 'twitter:card' => 'summary' }
      m = Ogpr::Model::TwitterCard.new(h)

      expect(m.meta).to eq(h)
    end
  end

  describe 'self.create' do
    context 'with meta which has no twitter tags' do
      let(:meta) do
        {
          'og:type' => 'website',
          'og:title' => 'sample site'
        }
      end

      it 'should return nil' do
        expect(Ogpr::Model::TwitterCard.create(meta)).to be_nil
      end
    end

    context 'with meta which has some twitter tags' do
      let(:meta) do
        {
          'twitter:card' => 'summary',
          'twitter:site' => '@twitter',
          'twitter:title' => 'summary title'
        }
      end

      it 'should return an instance of the TwitterCard model' do
        m = Ogpr::Model::TwitterCard.create(meta)
        expect(m).to be_an_instance_of(Ogpr::Model::TwitterCard)
        expect(m.meta).to eq(meta)
      end
    end
  end

  describe 'common attributes' do
    context 'when with meta data' do
      let(:meta) do
        {
          'twitter:card' => 'summary',
          'twitter:site' => '@twitter',
          'twitter:title' => 'summary site',
          'twitter:description' => 'summary description',
          'twitter:image' => 'https://example.com/path/to/image.png'
        }
      end

      describe '#type' do
        it 'should return twitter:card' do
          expect(model.type).to eq('summary')
        end
      end

      describe '#title' do
        it 'should return twitter:title' do
          expect(model.title).to eq('summary site')
        end
      end

      describe '#description' do
        it 'should return twitter:description' do
          expect(model.description).to eq('summary description')
        end
      end

      describe '#url' do
        it 'should return nil' do
          expect(model.url).to be_nil
        end
      end

      describe '#image' do
        it 'should return twitter:image' do
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
        'twitter:card' => 'summary',
        'twitter:site' => '@twitter',
        'twitter:title' => 'summary site',
        'twitter:description' => 'summary description',
        'twitter:image' => 'https://example.com/path/to/image.png'
      }
    end

    context 'when the property exists' do
      it 'should return the meta property value' do
        expect(model['title']).to eq('summary site')
        expect(model['image']).to eq('https://example.com/path/to/image.png')
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
        'twitter:card' => 'summary',
        'twitter:site' => '@twitter',
        'twitter:title' => 'summary site',
        'twitter:description' => 'summary description',
        'twitter:image' => 'https://example.com/path/to/image.png'
      }
    end

    it 'should return keys' do
      expect(model.keys).to match_array([
        'card', 'description', 'image', 'site', 'title'
      ])
    end
  end
end
