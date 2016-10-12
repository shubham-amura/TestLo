require 'spec_helper'

describe "Sign in" do

  before(:each) do
     @student=create(:student)
     @student.confirm
   end

    it "should allow a registered user to sign in" do
      visit "/"
      click_link "Sign In"
      fill_in "Email", :with => @student.email
      fill_in "Password", :with => @student.password
      click_button "Log in"
      page.should have_content("successfully")
    end

    it "should not allow a unregistered user to sign in" do
      visit "/"
      click_link "Sign In"
      fill_in "Email", :with => "unregistered@mail.com"
      fill_in "Password", :with => "anythin123"
      click_button "Log in"
      page.should have_content("Invalid")
    end
end
