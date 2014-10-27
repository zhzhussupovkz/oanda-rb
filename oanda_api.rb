=begin
/*

The MIT License (MIT)

Copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/
=end

require 'net/http'
require 'net/https'
require 'json'

#OandaApi - ruby wrapper
class OandaApi

  def initialize api_key, account_id
    @api_key, @account_id = api_key, account_id
    @api_url = "https://api-fxpractice.oanda.com/v1/accounts/#{account_id}/"
  end

  def get_request method, params = {}
    params = URI.escape(params.collect{ |k,v| "#{k}=#{v}"}.join('&'))
    url = @api_url + method + '/?' + params
    raise ArgumentError, "Can't send request to the server" if not url.is_a? String
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Get.new(uri.request_uri)
    req['Authorization'] = "Bearer #{@api_key}"
    req['Content-Type'] = 'application/x-www-form-urlencoded'
    res = http.request(req)
    if res.code == "200"
      data = res.body
      result = JSON.parse(data)
    else
      puts "Invalid getting data from server"
      exit
    end
  end

  def post_request method, params = {}
    params = URI.escape(params.collect{ |k,v| "#{k}=#{v}"}.join('&'))
    url = @api_url + method
    raise ArgumentError, "Can't send request to the server" if not url.is_a? String
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new(uri.request_uri)
    req['Authorization'] = "Bearer #{@api_key}"
    req['Content-Type'] = 'application/x-www-form-urlencoded'
    req.body = params
    res = http.request(req)
    if res.code == "200"
      data = res.body
      result = JSON.parse(data)
    else
      puts "Invalid getting data from server"
      exit
    end
  end

  def patch_request method, params = {}
    params = URI.escape(params.collect{ |k,v| "#{k}=#{v}"}.join('&'))
    url = @api_url + method
    raise ArgumentError, "Can't send request to the server" if not url.is_a? String
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Patch.new(uri.request_uri)
    req['Authorization'] = "Bearer #{@api_key}"
    req['Content-Type'] = 'application/x-www-form-urlencoded'
    req.body = params
    res = http.request(req)
    if res.code == "200"
      data = res.body
      result = JSON.parse(data)
    else
      puts "Invalid getting data from server"
      exit
    end
  end

  def delete_request method, params = {}
    url = @api_url + method
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Delete.new url
    req['Authorization'] = "Bearer #{@api_key}"
    req['Content-Type'] = 'application/x-www-form-urlencoded'
    req.body = params
    res = http.request(req)
    if res.code == "200"
      data = res.body
      result = JSON.parse(data)
    else
      puts "Invalid getting data from server"
      exit
    end
  end
end