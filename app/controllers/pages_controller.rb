class PagesController < ApplicationController
  def home
	@title = "Home"
  end

  def contact
  @title = "Bhanu"
  end
  
  def about
  @title = "about"
  end
end
