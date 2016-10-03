class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :test

  serialize :response,Hash
end
