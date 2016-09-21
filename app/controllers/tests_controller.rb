class TestsController < ApplicationController
  def new
    @test=current_user.tests.build()
  end

  def create

  end

end
