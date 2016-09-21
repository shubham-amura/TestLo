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
      redirect_to add_questions_test_path(@test)
    else
      render 'new'
    end
  end

  def add_questions
      #this will add qestions to test.
      @questions=Question.all
      @selected_questions=Enrollment.all.where(test_id:params[:id])
      #@selected_questions=Question.all
  end

  def push_questions
    
  end
  private
  def test_params
    params.require(:test).permit(:name,:date,:duration)
  end
end
