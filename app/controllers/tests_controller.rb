class TestsController < ApplicationController

  def index
    @tests=Test.all
  end

  def new
    @test=Test.new
  end

  def create
    @test=current_user.tests.create(test_params)
      if @test
        byebug
      flash[:success]="Test created Successfully"
      redirect_to new_test_question_path(@test.id)
    else
      render 'new'
    end
  end

  def destroy
      @test = Test.find(params[:id])
      @test.destroy
      redirect_to employer_dashboard_path

  end


  def show

    @questions = Question.all
    @selected_questions = TestQuestion.all.where(test_id:params[:id])
  end
  private
  def test_params
    params.require(:test).permit(:name,:date,:duration)
  end
end
