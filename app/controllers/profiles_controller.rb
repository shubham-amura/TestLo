class ProfilesController < ApplicationController
 before_action :authenticate_user!
 # before_action :authorize_user!
#before_action :l

  def show
    @user = current_user
    if @user.type = "Student"
      redirect_to student_dashboard_path
    else
      employer_dashboard
    end
  end


  def employer_dashboard

  end

  def student_dashboard
    
    @user = current_user
    @tests = Test.all
    @enrolled_test = Enrollment.all.where(student_id: current_user.id).pluck(:test_id)
 end

  def

  def edit

  end

end
