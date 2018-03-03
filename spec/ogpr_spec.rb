RSpec.describe Ogpr do
  describe 'self.fetch' do
    before do
      WebMock.enable!
      stub_request(:get, /example.com/).to_rack(FakeServer)
      stub_request(:head, /example.com/).to_rack(FakeServer)
    end
    after { WebMock.disable! }

    context 'when the url does not found' do
      it 'should throw error' do
        expect { Ogpr.fetch('https://example.com/error/not_found') }.to raise_error(/Got http status code\(404\)/)
      end
    end

    context 'when the content is a png file' do
      it 'should throw error' do
        expect { Ogpr.fetch('http://example.com/image.png').to raise_error(/Can't accept content-type: image\/png/) }
      end
    end

    context 'when the content is pdf file' do
      it 'should throw error' do
        expect { Ogpr.fetch('http://example.com/file.pdf') }.to raise_error(/Can't accept content-type: application\/pdf/)
      end
    end

    context 'when the content is a html file' do
      it 'should return an Ogpr::Result instance' do
        expect(Ogpr.fetch('http://example.com/page.html')).to be_an_instance_of(Ogpr::Result)
      end
    end
  end

  describe 'self.load' do
    context 'with a Hash object which contains TwitterCard/OpenGraph tags' do
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

      it 'should return an Ogpr::Result instance' do
        expect(Ogpr.load(hash)).to be_an_instance_of(Ogpr::Result)
      end
    end
  end

  describe 'self.parse' do
    context 'with a html string which contains TwitterCard/OpenGraph meta tags' do
      let(:html) { htmlContent('page.html') }

      it 'should return an Ogpr::Result instance' do
        expect(Ogpr.parse(html)).to be_an_instance_of(Ogpr::Result)
      end
    end
  end

  it "has a version number" do
    expect(Ogpr::VERSION).not_to be nil
  end
end
