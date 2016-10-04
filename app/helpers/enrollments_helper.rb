module EnrollmentsHelper


  def getValue(test,question)
    en=Enrollment.find_by(test_id:test.id,student_id:current_user.id)
    en.response["#{question.id}"]
  end
  def check_marked(test,question,mark)
    en=Enrollment.find_by(test_id:test.id,student_id:current_user.id)
    en.response["#{question.id}"]==mark
  end

  def check_marked_2(test,question,mark)
    en=Enrollment.find_by(test_id:test.id,student_id:current_user.id)
    en.response["#{question.id}"].include?mark
  end
end
