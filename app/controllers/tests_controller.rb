class TestsController < ApplicationController
    before_action :check_employer_profile, only: [:create, :new]
    before_action :get_test ,only:[:destroy,:activate,:privacy,:show]
    before_action :check_test_owner,only:[:destroy,:activate,:privacy]
    # check if user profile is complete
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
        # check if this test belongs to employee
        @test = Test.find(params[:id])
        if @test.employer_id == current_user.id
            @test.destroy
            flash[:success] = 'Deleted Successfully'
            redirect_to employer_dashboard_path
        else
            flash[:danger] = 'Can delete your own tests'
            redirect_to employer_dashboard_path
        end
    end

    def activate
        #get test
        # check if this test belongs to employee
        if @test.active
            @test.active = false
            if @test.save
                flash[:success] = 'Test is Not Active now'
                redirect_to employer_dashboard_path
            else
                flash[:danger] = 'Unable to deactivate,Try later'
                redirect_to employer_dashboard_path
            end
        else
            if @test.marks > 10 # condition
                @test.active = true
                if @test.save
                    flash[:success] = 'Test is Active now'
                    redirect_to employer_dashboard_path
                else
                    flash[:danger] = 'Unable to Activate ,try later'
                    redirect_to employer_dashboard_path
                end
            else
                flash[:danger] = 'Minimum marks for test is 10'
                redirect_to test_path(@test)
            end
        end
    end

    def privacy
        #get test
        @test = Test.find(params[:id])

        if @test.private
            @test.private = false
            if @test.save
                flash[:success] = 'This Test is public now'
                redirect_to employer_dashboard_path
            else
                flash[:danger] = 'Unable to change privacy,Try later'
                redirect_to test_path(@test)
            end
        else
            @test.private = true
            if @test.save
                flash[:success] = 'This Test is private now'
                redirect_to employer_dashboard_path
            else
                flash[:danger] = 'Unable to change privacy,Try later'
                redirect_to test_path(@test)
            end
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
        # check if this test belongs to employer
        @test = Test.find(params[:id])
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

    # Filters

    def check_employer_profile
        # byebug
        if current_user.employer_detail.nil?
            flash[:danger] = 'Complete profile first'
            redirect_to new_employer_details_path
        end
    end

    def get_test
      @test=Test.find(params[:id])
    end

    def check_test_owner
      #byebug
      unless @test.employer_id==current_user.id
        flash[:danger]="You are not owner of this test"
        redirect_to employer_dashboard_path
      end
    end
end
