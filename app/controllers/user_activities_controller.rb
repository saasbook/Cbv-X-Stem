class UserActivitiesController < ApplicationController
  before_action :set_user_activity, only: [:show, :edit, :update, :destroy]
  authorize_resource
  # GET /user_activities
  # GET /user_activities.json
  def index
    @user_holder = UserHolder.find params[:user_holder_id]
    @user_activities = @user_holder.user_activities.all
    @name = @user_holder.first_name + " " + @user_holder.last_name
  end

  # GET /user_activities/1
  # GET /user_activities/1.json
  def show
  end

  def details
    @user_activity = UserActivity.find(params[:id])
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
