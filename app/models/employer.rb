class Employer < User
  #with Details
  has_one :employer_detail

  #with tests
  has_many :tests
 end
