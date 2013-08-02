require 'sinatra'
require 'json'

#use Rack::Auth::Basic, "Restricted Area" do |username, password|
#  username == 'admin' and password == 'admin'
#end

get '*' do
  if request.path =~ /\/(\d\d\d)\/(.+)/
    status = $1.to_i
    if (300..399).include? status
      [status, {'Location' => $2.sub(':/', '://')}, ['']]
    else
      if (params[:callback])
        result = "#{params[:callback]}('#{$2}')"
      else
        result = $2
      end
      [status, {}, [result]]
    end
  else
    request.path
  end
end

post '*' do
  get_response
end

put '*' do
  get_response
end

delete '*' do
  get_response
end

def get_response
  [get_status, {}, [request.env["rack.input"].read]]
end

def get_status
  if request.path =~ /\/(\d\d\d)\/(.+)/
    $1.to_i
  else
    200
  end
end