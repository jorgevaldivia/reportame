class HomeController < ApplicationController
  def index
  end

  def blank
  	render layout: false
  end
end
