require "test_helper"

class UrlMapTest < ActiveSupport::TestCase
  test "url is a valid url" do
    bad_url = UrlMap.new(url: "google.ca", token: "abcdef7")
    valid = UrlMap.new(url: "https://google.ca", token: "abcdef7")

    assert valid.valid?
    refute bad_url.valid?
  end

  test "url and token are unique" do
    UrlMap.create!(url: "https://google.ca", token: "abcdef7")
    duplicate = UrlMap.new(url: "https://google.ca", token: "abcdef7")
    refute duplicate.valid?
  end

  test "token is a minimum of 7 characters" do
    bad_token = 'aB1'
    valid_token = 'AbCdef7'

    bad_url_map = UrlMap.new(url: "https://google.ca", token: bad_token)
    valid_url_map = UrlMap.new(url: "https://google.ca", token: valid_token)

    refute bad_url_map.token.length >= 7
    refute bad_url_map.valid?

    assert valid_url_map.token.length >= 7
    assert valid_url_map.valid?
  end

  test "token contains only alphanumeric characters" do
    valid_token = "Ab9def7"
    symbol_token = "&99d!f7"

    valid_map = UrlMap.new(url: "https://google.ca", token: valid_token)
    symbol_map = UrlMap.new(url: "https://google.ca", token: symbol_token)

    assert valid_map.valid?
    assert valid_map.token.match(/\A[a-zA-Z0-9]+\z/)

    refute symbol_map.valid?
    refute symbol_map.token.match(/\A[a-zA-Z0-9]+\z/)
  end
end
