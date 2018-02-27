require 'spec_helper'

RSpec.describe Ogpr::Fetcher::HtmlFetcher do
  before do
    WebMock.enable!
    stub_request(:get, /example.com/).to_rack(FakeServer)
    stub_request(:head, /example.com/).to_rack(FakeServer)
  end
  after { WebMock.disable! }

  def fetcher(url)
    Ogpr::Fetcher::HtmlFetcher.new(url)
  end

  describe '#fetch' do
    context 'when the content does not found' do
      it 'should throw error' do
        expect { fetcher("http://example.com/error/not_found").fetch }.to raise_error(/Got http status code\(404\)/)
      end
    end

    context 'when the content is a png file' do
      it 'should throw error' do
        expect { fetcher("http://example.com/image.png").fetch }.to raise_error(/Can't accept content-type: image\/png/)
      end
    end

    context 'when the content is a pdf file' do
      it 'should throw error' do
        expect { fetcher("http://example.com/file.pdf").fetch }.to raise_error(/Can't accept content-type: application\/pdf/)
      end
    end

    context 'when the content is a html file' do
      it 'should return html content' do
        expect(fetcher('http://example.com/page.html').fetch).to be_an_instance_of(String)
      end
    end
  end
end
