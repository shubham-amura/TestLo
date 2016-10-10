require 'spec_helper'

RSpec.describe TestsController, type: :controller do
  before(:each) do
    @employer_user = create(:employer)
    @employer_user.password = "admin123"
    @employer_user.save
    @employer_user.confirm
    sign_in @employer_user
    @employer_user.create_employer_detail(company: "Amura",company_address: "Pune", contact: "9860328030")
  end

  describe "POST" do
    it "creats new test" do
      params = {"name"=>"a", "date(1i)"=>"2016", "date(2i)"=>"10", "date(3i)"=>"10", "duration(1i)"=>"2016", "duration(2i)"=>"10", "duration(3i)"=>"10", "duration(4i)"=>"12", "duration(5i)"=>"57"}
       expect { post :create, test: params }.to change(Test, :count).by(1)
    end
  end

  describe "GET " do
    it "load new test page" do
      get :new
      expect(response.status).to eq (200)
    end

    it "List all test" do
      get :index
      expect(response.status).to eq (200)
    end

    it "Shows test" do
      params = {"name"=>"a", "date(1i)"=>"2016", "date(2i)"=>"10", "date(3i)"=>"10", "duration(1i)"=>"2016", "duration(2i)"=>"10", "duration(3i)"=>"10", "duration(4i)"=>"12", "duration(5i)"=>"57"}
      post :create, test: params
      current_test = @employer_user.tests.first
      get :show ,id: current_test.id
      expect(response.status).to eq (200)
    end
  end

  describe "DELETE" do
    it "Delete existinf test" do
      params = {"name"=>"a", "date(1i)"=>"2016", "date(2i)"=>"10", "date(3i)"=>"10", "duration(1i)"=>"2016", "duration(2i)"=>"10", "duration(3i)"=>"10", "duration(4i)"=>"12", "duration(5i)"=>"57"}
      post :create, test: params
      current_test = @employer_user.tests.first
      expect { delete :destroy , id:current_test.id }.to change(Test, :count).by(-1)
    end
  end



end
