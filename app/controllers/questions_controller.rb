class QuestionsController < ApplicationController
  #before_action :array_to_string,only:[:create]
  #to check params are valid depending on
  def new
    @question=Question.new
  end

  def index
    #add filter later
    # if params.has_key?(:filter)
    #   @questions=Question.all.where(category_id:params[:filter])
    # else
    #   @questions=Question.all
    # end
    @questions=Question.all
  end

  def create
    #options=params[:question][:temp_options].join('#####')
    #@user=Question.new(question_params)
    @question=Question.new(question_params)

    if @question.save
      flash[:success]="Question added to Bank successfully"
      #TestQuestion.create(test_id:)
      redirect_to questions_path
    else
      #form options doesnt read from single serialized column
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

  # def array_to_string
  #   if params[:question][:correct_answer].is_a?Array
  #     params[:question][:correct_answer]=params[:question][:correct_answer].join('#####')
  #   end
  #   params[:question][:options]=params[:question][:temp_options].join('#####')
  # end
end
