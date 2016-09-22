class QuestionsController < ApplicationController

  def new
  @question=Question.new
  end

  def index
    @questions=Question.all
  end

  def create
    @question=Question.new(question_params)

    if @question.save
      flash[:success]="Question added to Bank successfully"
      TestQuestion.create(test_id: params[:id],question_id: @question.id)
      @test = Test.find(params[:id])
      redirect_to add_questions_test_path(@test)
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
    p params.require(:question).permit(:category_id,:question_type,:question,:correct_answer,options:[])
  end

end
