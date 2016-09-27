require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @student=User.new(name:'swapnil',email:'swapnil@gmail.com',
    username:'coder123',password:'hello123',phone_no:'9028027761')
  end

  test "should not be blank" do
    #@student.name=""
    #assert_not @student.valid?
  end
end
