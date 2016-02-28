require 'minitest/autorun'
require_relative 'http_parser'

class HTTPParserTest < Minitest::Test
  def setup
    @request_get = "GET /?rolls=2&sides=6 HTTP/1.1"
    @request_get_2 = "GET /roll?rolls=4&sides=20 HTTP/1.1"
    @request_post = "POST /?rolls=2&sides=6 HTTP/1.1"
  end

  def test_method_get
    assert_equal 'GET', HTTPParser.method(@request_get)
  end

  def test_method_post
    assert_equal 'POST', HTTPParser.method(@request_post)
  end

  def test_method_path
    assert_equal '/', HTTPParser.path(@request_get)
  end

  def test_method_path_2
    assert_equal '/roll', HTTPParser.path(@request_get_2)
  end

  def test_params_1
    skip
    params = {"rolls" => "2", "sides" => "6"}
    assert_equal params, HTTPParser.params(@request_get)
  end

  def test_params_2
    skip
    params = {"rolls" => "4", "sides" => "20"}
    assert_equal 'GET', HTTPParser.params(@request_get_2)
  end
end

