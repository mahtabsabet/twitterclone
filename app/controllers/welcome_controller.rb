class WelcomeController < ApplicationController
  def index
  	@date = DateTime.now
  end
end
