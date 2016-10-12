class ProfilesController < ApplicationController
 before_action :authenticate_user!
def show
    @user = current_user
    if @user.type == "Student"
      redirect_to student_dashboard_path
    else
      redirect_to employer_dashboard_path
    end
  end
#Method for loading employer dashboard
#Employer must be logged in
  def employer_dashboard
    #send query parameter for filteration
    @tests = Test.employer_test_which_are(current_user,params[:q])
  end
#Method for loading Student dashboard
#enrolled test shows all enrolled test by the current student user
#tests are fetched from database which include all active test.
  def student_dashboard
    #send query paramater and enrolled test for filteration
    @enrolled_test = Enrollment.all.where(student_id:current_user.id).pluck(:test_id)
    @tests = Test.student_test_which_are_enrolled(current_user,params[:q],@enrolled_test,params[:page])
 end

end
