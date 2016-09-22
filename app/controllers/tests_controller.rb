class TestsController < ApplicationController

  def index
    @tests=Test.all
  end

  def new
    @test=Test.new
    # render plain: @test.inspect
  end

  def create
    @test=current_user.tests.create(test_params)
    # render plain: @test.inspect
    # #@test=current_user.tests.build(test_params)
    # render plain: params
    if @test
      flash[:success]="Test created Successfully"
      redirect_to new_test_question_path(@test)
    else
      render 'new'
    end
  end

  def show
    @test=Test.find(params[:id])
    @questions=Question.all
    @temp=TestQuestion.all.where(test_id:params[:id]).pluck(:question_id)
    @test_questions=[]
    @temp.each do |t|
      @test_questions << Question.find(t.to_i)
    end
  end

  private
  def test_params
    params.require(:test).permit(:name,:date,:duration)
  end
end
