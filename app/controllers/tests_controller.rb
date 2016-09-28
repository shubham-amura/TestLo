class TestsController < ApplicationController

  def index
    @tests=Test.all
  end

  def new
    #add filter to test wheather profile is complete or not
    #allow only if he has completed details
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


    def save
      #byebug
      @test=Test.find(params[:id])

      # No of questions
      noq=TestQuestion.where(:test_id=>@test.id).count
      @test.number_of_questions=noq

      # marks logic here
      total_marks=TestQuestion.where(:test_id=>@test.id).inject(0){|sum,test| sum+test.marks}
      @test.marks=total_marks

      #@test.marks=50
      if @test.save
        redirect_to employer_dashboard_path
      else
        render 'show'
      end
    end


    def add_question_to_current_test
        #create entry
        #byebug
        TestQuestion.create(test_id:params[:test_id],question_id:params[:question_id],marks:params[:marks])

        #test required in view to redirect
        @test = Test.find(params[:test_id])

        #get new list
        temp=TestQuestion.all.where(test_id:params[:test_id]).pluck(:question_id,:marks)
        @test_questions=[]
        temp.each do |q,m|
          @temp_question={}
          @temp_question[:question]=Question.find(q.to_i)
          @temp_question[:marks]=m
          @test_questions << @temp_question
        end


        #Dont show questions added in test ,so not.
        @questions = Question.where.not(id:temp)

      #redirect_to test_path(@test)
      respond_to do |format|
        format.js
      end

    end

    def remove_question_from_current_test
        q=TestQuestion.find_by(test_id:params[:test_id],question_id:params[:question_id])
        unless q.nil?
          q.destroy
        end

        #test required in view to redirect
        @test = Test.find(params[:test_id])

        temp=TestQuestion.all.where(test_id:params[:test_id]).pluck(:question_id,:marks)
        @test_questions=[]
        temp.each do |q,m|
          @temp_question={}
          @temp_question[:question]=Question.find(q.to_i)
          @temp_question[:marks]=m
          @test_questions << @temp_question
        end

        #Dont show questions added in test ,so not.
        @questions = Question.where.not(id:temp)

      #redirect_to test_path(@test)
      respond_to do |format|
        format.js
      end
    end

  def show
    @test=Test.find(params[:id])

    temp=TestQuestion.all.where(test_id:params[:id]).pluck(:question_id,:marks)
    @test_questions=[]
    temp.each do |q,m|
      @temp_question={}
      @temp_question[:question]=Question.find(q.to_i)
      @temp_question[:marks]=m
      @test_questions << @temp_question
      #@test_questions[:marks] << m
    end
    @questions = Question.where.not(id:temp)

    #byebug
  end


  private
  def test_params
    params.require(:test).permit(:name,:date,:duration)
  end
end
