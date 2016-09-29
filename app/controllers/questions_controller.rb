class QuestionsController < ApplicationController

  def new
    @test=Test.find(params[:test_id])
    @question=Question.new

  end

  def index
    @questions=Question.all
  end

  def create
    #byebug
    @question=Question.new(question_params)
    @test=Test.find(params[:test_id])
    if @question.save
      flash[:success]="Question added to Bank successfully"

      tq=TestQuestion.create(test_id:@test.id,question_id:@question.id)
      @test.marks+=tq.marks
      @test.number_of_questions+=1
      @test.save

      redirect_to test_path(@test)
    else
      @question.a=@question.options[0]
      @question.b=@question.options[1]
      @question.c=@question.options[2]
      @question.d=@question.options[3]
      render 'new'
    end
  end

  private
  def question_params
    #passing options and correct answers as arrays
    p params.require(:question).permit(:category_id,:question_type,:question,options:[],correct_answer:[])
  end
end
