class QuestionsController < ApplicationController
  before_action :array_to_string,only:[:create]
  #to check params are valid depending on
  def new
    @question=Question.new
  end

  def index

  end

  def create
    #options=params[:question][:temp_options].join('#####')
    #@user=Question.new(question_params)
    question_params
    render plain: params
  end

  private

  def question_params
    params.require(:question).permit(:question_type,:question,:options,:correct_answer,)
  end

  def array_to_string
    if params[:question][:correct_answer].is_a?Array
      params[:question][:correct_answer]=params[:question][:correct_answer].join('#####')
    end
    params[:question][:options]=params[:question][:temp_options].join('#####')
  end
end
