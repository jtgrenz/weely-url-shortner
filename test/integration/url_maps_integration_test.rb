require "test_helper"

class UrlMapsIntegrationTest < ActionDispatch::IntegrationTest

  test "can generate a new short url if url is not already mapped" do
    get '/url_maps/new'
    assert_response :success

    assert_difference('UrlMap.count', 1) do
      post '/url_maps', params: { url_map: { url: "https://not_saved123.google.com" } }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
    url_map = UrlMap.last

    assert_select "#short-url", URI.join(request.base_url, url_map.token).to_s
  end

  test "returns an existing short url if one already exists for url" do
    url_map = url_maps(:google_com)

    assert_not_nil url_map

    get '/url_maps/new'
    assert_response :success

    assert_difference('UrlMap.count', 0) do
      post '/url_maps', params: { url_map: { url: url_map.url } }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select "#short-url", URI.join(request.base_url, url_map.token).to_s
  end

  test "short url redirects to the mapped url" do
    url_map = url_maps(:google_com)

    get "/#{url_map.token}"
    assert_redirected_to url_map.url
  end

  test "/:token gets all redirect events" do
    skip
  end

  test "index lists all url maps" do
    skip
  end
end
