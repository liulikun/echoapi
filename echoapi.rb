require 'sinatra'
require 'json'

#use Rack::Auth::Basic, "Restricted Area" do |username, password|
#  username == 'admin' and password == 'admin'
#end
set :port, 9494
set :protection, :except => [:remote_referrer, :json_csrf]

get '*' do

  if request.path =~ /\/(\d\d\d)\/(.+)/
    status = $1.to_i
    if (300..399).include? status
      [status, {'Location' => $2.sub(':/', '://')}, ['']]
    else
      if (params[:callback])
        [status, {'Content-Type' => 'text/javascript'}, ["#{params[:callback]}('{\"text\":\"#{$2}\"}')"]]
      else
        [status, {'Content-Type' => 'application/json'}, [{:headers => get_request_headers, :params => params}.to_json]]
      end
    end
  else
    [200, {'Content-Type' => 'application/json'}, [{:path => request.path, :params => params}.to_json]]
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
  data = request.env["rack.input"].read
  content_type = request.content_type

  if content_type == 'application/json'
    response = JSON.dump({:headers => get_request_headers, :data => data})
  else
    response = data
  end
  [get_status, {'Content-Type' => request.content_type}, [response]]
end

def get_status
  if request.path =~ /\/(\d\d\d)\/(.+)/
    $1.to_i
  else
    200
  end
end

def get_request_headers
  headers = {}
  request.env.select{|h| h =~ /^HTTP_.*/}.each do |k, v|
    headers[k] = v
  end
  headers
end
