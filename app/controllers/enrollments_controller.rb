class EnrollmentsController < ApplicationController



  def taketest

    @current_test = Test.find(params[:test_id])
    @temp=TestQuestion.all.where(test_id:params[:test_id]).pluck(:question_id,:marks)
    @questions = Question.where(id:@temp.map{|a,b| a})
    @current_question = @questions.first

  end


  def show_current_question

    @current_question = Question.find(params[:id])
    respond_to do |format|
      format.js
  end
  end



  def submit_clicked

    byebug
    current_enrollment = Enrollment.find_by(test_id:params[:test_id],student_id:current_user.id)

    current_enrollment.response[:question_id] =

    respond_to do |format|
      format.js
    end
  end


end
