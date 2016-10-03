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
    #send query parameter for filteration
    @user = current_user
    q=params[:q]
    if q=="active"
      @tests = Test.all.where(employer_id: current_user.id,active:true)
    elsif q=="inactive"
      @tests = Test.all.where(employer_id: current_user.id,active:false)
    elsif q=="public"
      @tests = Test.all.where.not(employer_id:current_user.id).where(active:true,private:false)
    else
      @tests = Test.all.where(employer_id: current_user.id)
    end
  end

  def student_dashboard
    @user = current_user
    @tests = Test.all.page(params[:page])
    @enrolled_test = Enrollment.all.where(student_id: current_user.id).pluck(:test_id)
 end


#move this to enrollments
 def enroll_for_test
   #Add filter to complete profile of student
   #redirect to edit profile if profile is not completed.
   @user = current_user
   @tests = Test.all.page params[:page]
   Enrollment.create(student_id: current_user.id,test_id:params[:test_id])
   @enrolled_test = Enrollment.all.where(student_id: current_user.id).pluck(:test_id)

  respond_to do |format|
    format.js
  end
 end

end
