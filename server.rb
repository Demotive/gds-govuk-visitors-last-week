require 'rubygems'
require 'sinatra'
require 'json'
require 'rack-cache'
require 'net/http'
require 'net/https'
#require 'active_support/core_ext/hash'
#require 'active_support/core_ext/object'

use Rack::Cache
set :public_folder, 'public'
set :bind, '0.0.0.0'

get '/' do
  File.read(File.join('public', 'index.html'))
end

#===========

# Historic visitors
get '/govuk-historic-visitors' do
  cache_control :public, :max_age => 20
  http = Net::HTTP.new('www.performance.service.gov.uk', 443)
  http.use_ssl = true
  req = Net::HTTP::Get.new("/data/govuk/visitors?collect=visitors%3Asum&period=week&duration=1&filter_by=dataType%3Agovuk_visitors")
  response = http.request(req)
  response.body
end