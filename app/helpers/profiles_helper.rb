module ProfilesHelper
  def test_attempted(test_id)
    en=Enrollment.find_by(test_id:test_id,student_id:current_user.id)
    en.attempted
  end
end
