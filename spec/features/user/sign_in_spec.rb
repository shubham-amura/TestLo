require 'spec_helper'

describe "Sign in" do
  let(:student) do
     create(:student)
     student.confirm
   end

    it "should allow a registered user to sign in" do
      visit "/"
      click_link "Sign In"
      fill_in "Email", :with => student.email
      fill_in "Password", :with => student.password
      click_button "Log in"
      byebug
      page.should have_content("successfully")
    end
end
