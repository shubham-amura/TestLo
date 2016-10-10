class EnrollmentsController < ApplicationController
  include EnrollmentsHelper
  before_action :check_user
  before_action :check_student_profile,only:[:enroll_for_test,:taketest]
  before_action :get_test_by_id,only:[:taketest,:show_current_question,:submit_clicked]

  before_action :get_enrollment,only:[:taketest,:submit_clicked]
  before_action :check_test_time,only:[:taketest,:submit_clicked]

  def taketest
    #check_student_profile
    #get_test_by_id
    #get_enrollment(also check enrolled or not)
    #check_time
    join_data
    @enrollment.record_start_time
    @now=@enrollment.get_start_time
  end


  def show_current_question
    #get_test_by_id
    @current_question = Question.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def submit_clicked
    #test
    #enrollments
    #time

    @question_id=params[:question][:id]
    @response=params[:response]

    unless @response.nil? || @response.empty?
      @enrollment.response[@question_id]=@response.is_a?(Array) ? @response:[@response]
      @enrollment.save
    end

    join_data
    @now=@enrollment.start_time.getlocal
    #redirect_to taketest_path(@current_test)
    respond_to do |format|
      format.js
    end
  end

  def enroll_for_test
    #check_profile _complete
    @user=current_user
    @tests = Test.all.page(params[:page])
    Enrollment.create(student_id: current_user.id,test_id:params[:test_id])
    @enrolled_test = Enrollment.all.where(student_id: current_user.id).pluck(:test_id)

    respond_to do |format|
      format.js
    end
  end


  def finish
    #to be done with joins
    @test=Test.find(params[:test_id])
    @score=0
    en=Enrollment.find_by(test_id:params[:test_id],student_id:current_user.id)
    user_response_hash=en.response

    temp=TestQuestion.all.where(test_id:params[:test_id]).pluck(:question_id,:marks)
    correct_response_hash={}

    temp.each do |id,marks|
      question=Question.find(id)
      correct_response_hash[id]={:cr=>question.correct_answer,:marks=>marks}
    end

    temp.map{|a,b| a}.each do |t|
        if user_response_hash["#{t}"]==correct_response_hash[t][:cr]
          @score+=correct_response_hash[t][:marks]
        end
    end
    en.score=@score
    en.attempted=true
    en.save

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def get_enrollment
    @enrollment=Enrollment.find_by(test_id:@current_test.id,student_id:current_user.id)
    if @enrollment.nil?
      flash[:danger]="Enroll First"
      redirect_to student_dashboard_path
    end
  end

  def get_test_by_id
    @current_test = Test.find_by(id:params[:test_id])
    if @current_test.nil?
      flash[:danger]="Test doesnt exist"
      redirect_to student_dashboard_path
    end
  end

  def get_test_by_id_2
    @current_test = Test.find_by(id:params[:test][:id])
    if @current_test.nil?
      flash[:danger]="Test doesnt exist"
      redirect_to student_dashboard_path
    end
  end

  def check_user
      unless current_user.type=="Student"
        flash[:danger]="Authorizaion Error"
        redirect_to error_path
      end
  end

  def check_student_profile
        if current_user.student_detail.nil?
          if request.xhr?
            flash[:danger]= 'Complete profile first'
            render :js => "window.location = #{new_student_details_path.to_json}"
          else
            flash[:danger]= 'Complete profile first'
            redirect_to new_student_details_path
          end
        end
  end

  def check_test_time
    unless @enrollment.start_time.nil?
      #if
      #if user is trying to take test more than once
      if Time.now.utc > @enrollment.start_time.plus_with_duration(get_total_seconds(@current_test.duration))
        flash[:danger]="Time is over"
        #if not attempted and time is over ,call finish action
        unless @enrollment.attempted
          if request.xhr?
            render :js => "window.location = #{finish_path.to_json}"
          else
            redirect_to finish_path
          end
        else
          if request.xhr?
            render :js => "window.location = #{student_dashboard_path.to_json}"
          else
            redirect_to student_dashboard_path
          end
        end
      end
    end
  end

  def join_data
    #all questions in test
    @test_questions=TestQuestion.get_questions_of_test(@current_test)
    #filter attempted
    @unattempted=@test_questions.select{|t| question_attempted(t.question.id,@current_test.id)==false}

    #current_question is always first unqttempted
    unless @unattempted.empty?
      #select first question from unattempted list
      @current_question = @unattempted.first.question
      #get unattempted sorted by question ids
    else
      #if all are attempted then select first question from list
      #unqttempted will be empty
      @current_question=@test_questions.first.question
    end
  end

end
