module UrlMapsHelper

  def short_url(url_map)
    URI.join(request.base_url, url_map.token).to_s
  end
end
