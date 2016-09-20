class QuestionsController < ApplicationController
  def new
    @question=Question.new
  end

  def index

  end

  def create
    p params
  end

end
