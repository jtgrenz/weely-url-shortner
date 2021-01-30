class UrlMapsController < ApplicationController
  include UrlMapsHelper

  def index
    @url_maps = UrlMap.all
  end

  def new
    @url_map = UrlMap.new
  end

  def create
    @url_map = UrlMap.find_or_initialize_by(url: normalized_url_param)
    if @url_map.save
      flash[:short_url] = short_url(@url_map) #"Your shortened url is: <a id='short-url' data-turbolinks=false href='#{short_url(@url_map)}'>#{short_url(@url_map)}</a>'."
    else
      flash[:errors] = @url_map.errors.full_messages
    end
    redirect_to new_url_map_path
  end

  def short_url_redirect
    @url_map = UrlMap.find_by(token: params[:token])
    @redirect_event = RedirectEvent.create!(url_map: @url_map, ip_address: request.ip)
    redirect_to @url_map.url
  end

  def show
    @url_map = UrlMap.find_by(token: params[:token])
  end

  private

  def url_params
    params.require(:url_map).permit(:url)
  end

  def normalized_url_param
    uri = URI.parse(url_params[:url])
    if uri.scheme.nil? && uri.host.nil?
      unless uri.path.nil?
        uri.scheme = "http"
        uri.host = uri.path
        uri.path = ""
      end
    end
    uri.to_s
  rescue URI::InvalidURIError
    # Url is invalid. This will be caught by url validator on UrlMap model.
    url_params[:url]
  end
end
