class WorkExperiencesController < ApplicationController 
    before_action :authenticate_user!
    before_action :set_work_experience, only: %i[edit update destroy]

    def new 
    @work_experience = current_user.work_experiences.new
    end

    def edit ; end
    def create; end
    def update; end
    def destroy; end
private 
def set_work_experience
@work_experience = current_user.work_experiences.find(params[:id])
end
def work_experience_params
    params.require(:work_experience).permit(:start_date, :end_date, :job_title, :employment_type, :location, :location_type, :currently_working_here, :description, :company, :user_id)
end
end 
