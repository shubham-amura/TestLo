class DetailsController < ApplicationController

  def edit
      @user=User.find(current_user.id)

      if @user.type=="Student"
            redirect_to edit_student_details_path
      else
            redirect_to new_employer_details_path
      end

  end

  def edit_student_details
      #byebug
      @student=Student.find(current_user.id)

      if @student.student_detail.nil?
            redirect_to new_student_details_path
      end
  end

  def new_student_details
      @student=Student.find(current_user.id)
  end

  def create_student_details
      @student=Student.find(current_user.id)
      if @student.create_student_detail(student_details_params)
        flash[:success]="Profile Updated Successfully"
        redirect_to student_dashboard_path
      else
        render 'new_student_details'
      end
  end

  def update_student_details
    @student=Student.find(current_user.id)
    if @student.student_detail.update_attributes(student_details_params)
      flash[:success]="Profile Updated Successfully"
      redirect_to student_dashboard_path
    else
      render 'edit_student_details'
    end
  end

  private
    def student_details_params
      params.require(:student_detail).permit(:age,:college,:resume,:experience,:skills)
    end
end
