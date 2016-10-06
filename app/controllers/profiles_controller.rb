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
    @enrolled_test = Enrollment.all.where(student_id:current_user.id).pluck(:test_id)

    q=params[:q]

    if q=="enrolled"
      @tests = Test.all.where(active:true,id:@enrolled_test).where("date >= ?",Date.today).page(params[:page])
    elsif q=="not enrolled"
      #not enrolled and not expired yet
      @tests = Test.all.where.not(id:@enrolled_test).where(active:true).where("date >= ?",Date.today).page(params[:page])
    elsif q=="expired"
      @tests = Test.all.where.not(id:@enrolled_test).where(active:true).where("date < ?",Date.today).page(params[:page])
    elsif q=="attempted"
      @enrolled_test = Enrollment.all.where(student_id:current_user.id,attempted:true).pluck(:test_id)
      @tests=Test.all.where(id:@enrolled_test).page(params[:page])
    else
      @tests = Test.all.where(active:true).page(params[:page])
    end
 end

end
