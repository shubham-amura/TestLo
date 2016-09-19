class ProfilesController < ApplicationController
 before_action :authenticate_user!
 before_action :authorize_user!
#before_action :l
  def show
    @user = current_user
  end

  def edit
  end




end
