require 'sinatra'
require 'json'

#use Rack::Auth::Basic, "Restricted Area" do |username, password|
#  username == 'admin' and password == 'admin'
#end

get '*' do

  require 'pp'
  pp request.env.select{|h| h =~ /^HTTP_.*/}

  if request.path =~ /\/(\d\d\d)\/(.+)/
    status = $1.to_i
    if (300..399).include? status
      [status, {'Location' => $2.sub(':/', '://')}, ['']]
    else
      if (params[:callback])
        [status, {'Content-Type' => 'text/javascript'}, ["#{params[:callback]}('{\"text\":\"#{$2}\"}')"]]
      else
        [status, {}, ["#{$2}"]]
      end
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
