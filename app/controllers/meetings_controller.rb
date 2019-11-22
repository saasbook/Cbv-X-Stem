class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  # GET /meetings.json
  def index
    # @meetings = Meeting.all
    if params[:user_holder_id]
      @cur_user_holder =  current_user.user_holder
      @meetings = @cur_user_holder.meetings
    else
      @meetings = Meeting.all
    end

  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show

  end

  # GET /meetings/new
  def new
    @cur_user_holder =  current_user.user_holder
    # @meetings = @cur_user_holder.meetings
    # @meeting = Meeting.new
    @new_meeting = @cur_user_holder.meetings.new
  end

  # GET /meetings/1/edit
  def edit
    # @cur_user_holder =  current_user.user_holder
    # @new_meeting = @cur_user_holder.meetings.new
    @new_meeting = @meeting


  end

  # POST /meetings
  # POST /meetings.json
  def create
    @cur_user_holder = current_user.user_holder
    @meeting = @cur_user_holder.meetings.create(meeting_params)
    @meeting.user_holder_id = @cur_user_holder.user_id
    puts(@meeting.id)
    puts(@meeting.user_holder_id)
    puts(@cur_user_holder.id)
    puts( current_user.id)


    respond_to do |format|
      if @meeting.save
         format.html { redirect_to user_holder_meetings_path, notice: 'Meeting was successfully created.' }
         format.json { render :show, status: :created, location: @meeting }
        # redirect_to
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update

    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to user_holder_meetings_path, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to user_holder_meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_doctor_schedule
    @something = current_user.id
    @booked = Meeting.where(patient_id: current_user.id)
    @meetings = Meeting.where(patient_id: [nil, ""]).order :start_time
  end

  def book
    respond_to do |format|
    @meeting = Meeting.where(:id =>params[:meeting_id]).first
    puts @meeting.id
    @meeting.patient_id = params[:id]
    puts @meeting.patient_id
    @meeting.save

      format.html { redirect_to show_doctor_schedule_path, notice: 'Meeting was successfully booked.' }
      format.json { render :show, status: :ok, location: @meeting }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:name, :start_time, :end_time)
    end
end
