class ProfilesController < ApplicationController
 before_action :authenticate_user!
 # before_action :authorize_user!
#before_action :l

  def show
    @user = current_user
    if @user.type == "Student"
      redirect_to student_dashboard_path
    else
      redirect_to employer_dashboard_path
    end
  end

  def employer_dashboard
    @user = current_user
    @created_tests = Test.all.where(employer_id: current_user.id)
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
