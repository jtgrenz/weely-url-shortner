class UrlMapsController < ApplicationController
  include UrlMapsHelper

  def index
    @url_maps = UrlMap.all
  end

  def new
    @url_map = UrlMap.new
  end

  def create
    @url_map = UrlMap.find_or_create_by!(url_params)
    flash[:notice] = "Your shortened url is: <a id='short-url' href='#{short_url(@url_map)}'>#{short_url(@url_map)}</a>'."
    redirect_to new_url_map_path
  end

  def short_url_redirect
    @url_map = UrlMap.find_by(token: params[:token])
    # save ip address
    redirect_to @url_map.url
  end

  def show
    @url_map = UrlMap.find_by(token: params[:token])
  end

  private

  def url_params
    params.require(:url_map).permit(:url)
  end
end
