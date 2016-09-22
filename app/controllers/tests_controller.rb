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

      flash[:success]="Test created Successfully"

      redirect_to test_path(@test)
  else
      render 'new'
    end
  end


  def destroy
      @test = Test.find(params[:id])
      @test.destroy
      redirect_to employer_dashboard_path

  end

    def add_question_to_current_test

        TestQuestion.create(test_id:params[:test_id],question_id:params[:question_id])
        temp=TestQuestion.all.where(test_id:params[:test_id]).pluck(:question_id)
        @test_questions=[]
        temp.each do |t|
          @test_questions << Question.find(t.to_i)
        end
        @test = Test.find(params[:test_id])
        @questions = Question.where.not(id:temp)

      respond_to do |format|
        format.js
      end

    end


  def show
    @test=Test.find(params[:id])

    temp=TestQuestion.all.where(test_id:params[:id]).pluck(:question_id)

    @questions = Question.where.not(id:temp)

    @test_questions=[]
    temp.each do |t|
      @test_questions << Question.find(t.to_i)
    end
  end


  private
  def test_params
    params.require(:test).permit(:name,:date,:duration)
  end
end
