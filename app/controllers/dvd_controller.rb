class DvdController < ApplicationController
  def list
    @dvds = Dvd.find(:all)
    @title = "DVD Shelf All DVDs"
  end
end
