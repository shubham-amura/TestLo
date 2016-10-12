require 'spec_helper'

describe "Employer" do

  before(:each) do
     @employer=create(:employer)
     @employer.confirm
     @date=Date.today
     @time=Time.now

   end

    it "should redirect to profile completion before creating test" do
      visit "/"
      click_link "Sign In"
      fill_in "Email", :with => @employer.email
      fill_in "Password", :with => @employer.password
      click_button "Log in"
      click_link "My Tests"
      click_link "Create Test"
      page.should have_content("Complete profile first")
    end

    # it "should not allow a unregistered employer user " do
    #   visit "/"
    #   click_link "Sign In"
    #   fill_in "Email", :with => "unregistered@mail.com"
    #   fill_in "Password", :with => "anythin123"
    #   click_button "Log in"
    #   page.should have_content("Invalid")
    # end
end
