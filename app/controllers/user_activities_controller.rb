class UserActivitiesController < ApplicationController
  before_action :set_user_activity, only: [:show, :edit, :update, :destroy]

  # GET /user_activities
  # GET /user_activities.json
  def index
    @user_activities = UserActivity.all
  end

  # GET /user_activities/1
  # GET /user_activities/1.json
  def show
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_activity
      @user_activity = UserActivity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_activity_params
      params.require(:user_activity).permit(:actor, :action, :category, :original_val, :new_val, :description, :user_holder_id)
    end
end
