class HomeController < ApplicationController
  
  def main
    @user = User.new
    @resume = Resume.new
  end
   
end
