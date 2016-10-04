class Student < User
	#with student details
	has_one :student_detail

	#with tests
	has_many :enrollments,dependent: :destroy
	has_many :tests,through: :enrollments
end
