module EnrollmentsHelper


  def getValue(test,question)
    en=Enrollment.find_by(test_id:test.id,student_id:current_user.id)
    en.response["#{question.id}"]
  end

  def check_marked(test,question,mark)
    en=Enrollment.find_by(test_id:test.id,student_id:current_user.id)
    en.response["#{question.id}"]==[mark]
  end

  def check_marked_2(test,question,mark)
    en=Enrollment.find_by(test_id:test.id,student_id:current_user.id)
    en.response["#{question.id}"].include?mark if en.response["#{question.id}"]!=nil
  end


  def get_question(id)
    return Question.find(id)
  end

  def question_attempted(q_id,test_id)
    en=Enrollment.find_by(test_id:test_id,student_id:current_user.id)
    en.response.key?("#{q_id}")
  end

  def get_total_seconds(t)
    total=t.hour*60*60 + t.min*60 + t.sec
    return total;
  end

end
