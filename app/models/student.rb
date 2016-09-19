class Student < User
	#with student details
	has_one :student_detail

	#with tests
	has_many :enrollments
	has_many :tests,:through :enrollments
end
