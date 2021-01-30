require "test_helper"

class UrlMapTest < ActiveSupport::TestCase
  test "url is a valid url" do
    bad_url = UrlMap.new(url: "google.ca", token: "abc")
    valid = UrlMap.new(url: "https://google.ca", token: "abc")

    assert valid.valid?
    refute bad_url.valid?
  end

  test "url and token are unique" do
    UrlMap.create!(url: "https://google.ca", token: "abc")
    duplicate = UrlMap.new(url: "https://google.ca", token: "abc")
    refute duplicate.valid?
  end

  test "token is a minimum of 3 letters" do
    url_map = UrlMap.new(url: "https://google.com", token: "a")
    refute url_map.valid?
  end

  test "token contains lowercase letters from a-z" do
    upper_map = UrlMap.new(url: "https://google.com", token: "ABC")
    number_map = UrlMap.new(url: "https://google.com", token: "123")
    symbol_map = UrlMap.new(url: "https://google.com", token: "@%*")

    refute upper_map.valid?
    refute number_map.valid?
    refute symbol_map.valid?
  end
end
