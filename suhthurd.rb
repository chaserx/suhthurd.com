require 'rubygems'
require 'sinatra'

set :public, Proc.new { File.join(root, "_site") }

# This before filter ensures that your pages are only ever served 
# once (per deploy) by Sinatra, and then by Varnish after that
before do
  response.headers['Cache-Control'] = 'public, max-age=31557600' # 1 year
end

get '/' do
  File.read('_site/index.html')
end

configure :production do

   not_found do
     File.read('_site/404.html')
   end

   error do
     "Something really nasty happened.  We're on it!"
   end

 end