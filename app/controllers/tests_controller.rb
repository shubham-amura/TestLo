class TestsController < ApplicationController
    before_action :check_employer_profile, only: [:create, :new]
    before_action :get_test_by_id ,only:[:destroy,:activate,:privacy,:show]
    before_action :check_test_owner,only:[:destroy,:activate,:privacy]
    before_action :get_test_by_test_id,only:[:add_question_to_current_test,:remove_question_from_current_test]

    def index
        @tests = Test.all
    end

    def new
        # check_employer_profile filter
        @test = Test.new
    end

    def create
        @test = current_user.tests.create(test_params)
        if @test
            flash[:success] = 'Test created Successfully'
            redirect_to test_path(@test)
        else
            render 'new'
        end
    end

    def destroy
        #get test
        #check_test_owner
        @test.destroy
        flash[:success] = 'Deleted Successfully'
        redirect_to employer_dashboard_path
    end

    def activate
        #get test
        #check_test_owner
        if @test.active
            activate_and_flash
        else
          if @test.marks > 10 # condition
            activate_and_flash
          else
            flash[:danger] = 'Minimum marks for test is 10'
          end
        end
        redirect_to test_path(@test)
    end

    def privacy
        #get test
        #check_test_owner
        @test.toggle(:private)
        if @test.save
          flash[:success] ="This test is #{@test.private? ? 'Private' : 'Public'} now"
          redirect_to test_path(@test)
        else
          flash[:danger] = 'Unable to change privacy,Try later'
          redirect_to test_path(@test)
        end
    end

    def add_question_to_current_test
        # check test belongs to employee
        # create entry in test question
        tq = TestQuestion.create(test_id: params[:test_id], question_id: params[:question_id], marks: params[:marks])

        # test required in view to redirect and change the marks and noq after addition
        @test = Test.find(params[:test_id])
        @test.marks += tq.marks.to_i
        @test.number_of_questions += 1
        @test.save

        # View data logic

        # left partial , all test questions and their assigned marks
        temp = TestQuestion.all.where(test_id: params[:test_id]).pluck(:question_id, :marks)
        @test_questions = []
        temp.each do |q, m|
            @temp_question = {}
            @temp_question[:question] = Question.find(q.to_i)
            @temp_question[:marks] = m
            @test_questions << @temp_question
        end

        # Dont show questions added in test ,so not.
        @questions = Question.where.not(id: temp)

        # redirect_to test_path(@test)

        # ajax ,remote true
        respond_to do |format|
            format.js
        end
    end

    def remove_question_from_current_test
        # check if this test belongs to employer
        @test = Test.find(params[:test_id])

        if @test.active
            flash[:danger] = 'Deactivate test first'
            return redirect_to test_path(@test)
        end

        q = TestQuestion.find_by(test_id: params[:test_id], question_id: params[:question_id])
        q.destroy unless q.nil?

        # test required in view to redirect
        # @test = Test.find(params[:test_id])
        @test.marks -= q.marks.to_i
        @test.number_of_questions -= 1
        @test.save

        # view logic
        temp = TestQuestion.all.where(test_id: params[:test_id]).pluck(:question_id, :marks)
        @test_questions = []
        temp.each do |q, m|
            @temp_question = {}
            @temp_question[:question] = Question.find(q.to_i)
            @temp_question[:marks] = m
            @test_questions << @temp_question
        end

        # Dont show questions added in test ,so not.
        @questions = Question.where.not(id: temp)

        # redirect_to test_path(@test)
        respond_to do |format|
            format.js
        end
    end

    def show
        #get test
        #check_test_owner
        temp = TestQuestion.all.where(test_id: params[:id]).pluck(:question_id, :marks)
        @test_questions = []
        temp.each do |q, m|
            @temp_question = {}
            @temp_question[:question] = Question.find(q.to_i)
            @temp_question[:marks] = m
            @test_questions << @temp_question
            # @test_questions[:marks] << m
        end
        @questions = Question.where.not(id: temp)
    end

    private

    def test_params
        params.require(:test).permit(:name, :date, :duration)
    end

    def activate_and_flash
      #toggles test activation and displays appropriate flash
      @test.toggle(:active)
      if @test.save
          flash[:success] = "Test is #{@test.active? ? 'Active' : 'Inactive'} now"
      else
          flash[:danger] = 'Unable to deactivate,Try later'
      end
    end
    # Filters

    def check_employer_profile
        # byebug
        if current_user.employer_detail.nil?
            flash[:danger] = 'Complete profile first'
            redirect_to new_employer_details_path
        end
    end

    def get_test_by_id
      @test=Test.find(params[:id])
    end

    def get_test_by_test_id
      @test=Test.find(params[:test_id])
    end

    def check_test_owner
      #byebug
      unless @test.employer_id==current_user.id
        flash[:danger]="You are not owner of this test"
        redirect_to employer_dashboard_path
      end
    end
end
