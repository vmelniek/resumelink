class UsersController < ApplicationController
  
  #before_filter :authenticate_user!, :except => [:new]
  
  protect_from_forgery :except => :checkuser
  
  def show
     @user = User.find(params[:id])
  end
  
  def edit
     @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    
    @user.update_attributes ( params[:user] )
    if @user.valid?
      
      user = User.authenticate(params[:user][:username], params[:user][:email], params[:user][:password])
      session[:user_id] = user.id
      render "show"
      
    else
      render "edit"
    end
    
  end
  
  def preload
    puts "Params #{params[:user]}"
    
    if params[:user].nil? 
      @user = User.new
      @user.resume_file = nil
      
      render "edit"
    elsif !params[:user][:username].nil?
      @user = User.new
      @user.username = params[:user][:username]
      @user.resume_file = nil
      
      if User.exists?(:username => params[:user][:username])
        redirect_to root_url, :notice => "Username already exists, choose another one!"
      else
        render "edit"
      end
    else
      @user = User.new
      @user.newly_created = true
      @user.save

      @resume = Resume.new
      @resume.resume_file = params[:user][:resume_file]
      @resume.user_id = @user.id
      @resume.save

      @user.resume_file = @resume.resume_file

      @user.newly_created = false
      
      render "edit"
    end
  end
  
  def checkuser
    @user = User.find_by_username(params[:user_username])
    if @user
      render :text => true, :layout => false
    elsif params[:user_username].blank?
      render :text => true, :layout => false
    else
      render :text => false, :layout => false
    end
  end
  
  def show2
    @user = User.find_by_username(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.username.empty?
      @user.username = nil
    end
    
    if @user.valid?
      @user.save
      
      if params[:user][:resume_file]
        resume = Resume.new
        resume.resume_file = params[:user][:resume_file]
        resume.user_id = @user.id
        resume.save
      end
      
      user = User.authenticate(params[:user][:username], params[:user][:email], params[:user][:password])
      session[:user_id] = user.id
      
      puts "USER SESSION #{session[:user_id]}"
      redirect_to user_url(user.id), :notice => "Logged in!"
    else
      flash[:errors] = "problem creating a user"
      render :action => "new"
    end
  end
  
  def login
    
  end
end
