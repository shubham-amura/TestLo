class EnrollmentsController < ApplicationController

  before_action :check_student_profile,only:[:enroll_for_test,:taketest]


  def taketest
    #check_student_profile
    @current_test = Test.find(params[:test_id])

    @temp=TestQuestion.all.where(test_id:params[:test_id]).pluck(:question_id,:marks)
    @questions = Question.where(id:@temp.map{|a,b| a})
    
    #todisplay first question ,right side partial
    @current_question = @questions.first
  end


  def show_current_question
    @current_question = Question.find(params[:id])
    @current_test=Test.find(params[:test_id])
    @current_enrollment = Enrollment.find_by(test_id:params[:test_id].to_i,student_id:current_user.id)
    respond_to do |format|
    format.js
    end
  end

  def submit_clicked
    #byebug
    @current_enrollment = Enrollment.find_by(test_id:params[:test][:id].to_i,student_id:current_user.id)
    @question_id=params[:question][:id]
    @response=params[:response]
    @current_enrollment.response[@question_id]=@response.is_a?(Array) ? @response:[@response]
    @current_enrollment.save

    #redirect_to taketest_path(test_id:params[:test_id])
    respond_to do |format|
      format.js
    end
  end

  def enroll_for_test
    #check_student_profile
    @user = current_user
    @tests = Test.all.page params[:page]
    Enrollment.create(student_id: current_user.id,test_id:params[:test_id])
    @enrolled_test = Enrollment.all.where(student_id: current_user.id).pluck(:test_id)

    respond_to do |format|
      format.js
    end
  end


  def finish
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
    en.save

    byebug
  end

  private

  def check_student_profile
      if current_user.student_detail.nil?
          flash[:danger] = 'Complete profile first'
          return redirect_to new_student_details_path
      end
  end
end
