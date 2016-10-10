require 'spec_helper'

RSpec.describe ProfilesController, type: :controller do
  context "For Employer" do
      before(:each) do
        @employer_user = create(:employer)
        @employer_user.password = "admin123"
        @employer_user.save
        @employer_user.confirm
        sign_in @employer_user
      end
      describe "GET" do
        it "Get Employer Dashboard" do
          get :employer_dashboard
          expect(response.status).to eq (200)
        end
        it "Check Show method for employer" do
          get :show, id: @employer_user.id
          expect(response.status).to eq (302)
        end
      end
  end

  context "For Student" do
    before(:each) do
      @student_user = create(:student)
      @student_user.password = "admin123"
      @student_user.save
      @student_user.confirm
      sign_in @student_user
    end
    describe "Get Methods" do
        it "Get student dashboard" do
          get :student_dashboard
          expect(response.status).to eq (200)
        end

        it "Check Show method" do
          get :show,id: @student_user.id
          expect(response.status).to eq (302)
        end
    end
  end
end
