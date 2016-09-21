class TestsController < ApplicationController

  def index
    @tests=Test.all
  end

  def new
    @test=Test.new
    # render plain: @test.inspect
  end

  def create
    @test=current_user.tests.build(test_params)
    render 'add_questions'
    
    # @test=current_user.tests.create(test_params)
    # render plain: @test.inspect
    # #@test=current_user.tests.build(test_params)
    # render plain: params
    # if current_user.tests.create(test_params)
    #   flash[:success]="Test created Successfully"
    #   redirect_to profile_path(current_user)
    # else
    #   render 'new'
    # end
  end
  private
  def test_params
    params.require(:test).permit(:name,:date,:duration)
  end
end
