require 'sinatra/base'

class FakeServer < Sinatra::Base
  [
    {name: 'page.html', type: :html},
    {name: 'image.png', type: :png},
    {name: 'file.pdf',  type: :pdf}
  ].each do |v|
    get "/#{v[:name]}" do
      content_type v[:type]
      status 200

      file_path = Pathname.new(__dir__).join('contents', v[:name])
      logger.info "file_path: #{file_path}"
      send_file file_path
    end

    head "/#{v[:name]}" do
      content_type v[:type]
      status 200
    end
  end
end
