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
    @tests = Test.all.page(params[:page])
    @enrolled_test = Enrollment.all.where(student_id: current_user.id).pluck(:test_id)
 end



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

  def edit
    @user = current_user
    if @user.type == "Student"
      redirect_to profiles_student_details_path
    else
      redirect_to profiles_employer_details_path
    end
  end


  def student_details
    @user=current_user
    if @user.student_detail.nil?
      @student_details=@user.build_student_detail
    else
      @student_details=@user.student_detail
    end
  end

  def employer_details

  end

  def student_update
    byebug
    redirect_to student_dashboard_path
  end

  def employer_update
    redirect_to employer_dashboard_path
  end
end
