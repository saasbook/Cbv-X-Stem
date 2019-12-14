class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  include MeetingsHelper
  # GET /meetings
  # GET /meetings.json
  def index
    # # @meetings = Meeting.all
    # # Why check params for user_holder, but then using the root user one?
    # # I assume it is root user for now.
    # if params[:user_holder_id]
    #   @cur_user_holder =  current_user.user_holder
    #   @meetings = @cur_user_holder.meetings
    # else
    #   # No point to show all meeting.
    #   @meetings = Meeting.all
    # end
    @pending_meetings = current_user.user_holder.meetings.where(status: "pending")
    @confirmed_meetings = current_user.user_holder.meetings.where(status: "confirmed")
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show

  end

  # GET /meetings/new
  # def new
  #   @cur_user_holder =  current_user.user_holder
  #   # @meetings = @cur_user_holder.meetings
  #   # @meeting = Meeting.new
  #   @new_meeting = @cur_user_holder.meetings.new
  # end

  # GET /meetings/1/edit
  def edit
    # @cur_user_holder =  current_user.user_holder
    # @new_meeting = @cur_user_holder.meetings.new
    @new_meeting = @meeting


  end

  # POST /meetings
  # POST /meetings.json
  # def create
  #   @cur_user_holder = current_user.user_holder
  #   @meeting = @cur_user_holder.meetings.create(meeting_params)
  #   @meeting.status = "available"
  #   # @meeting.user_holder_id = @cur_user_holder.user_id

  #   respond_to do |format|
  #     if @meeting.save
  #        format.html { redirect_to user_holder_meetings_path, notice: 'Meeting was successfully created.' }
  #        format.json { render :show, status: :created, location: @meeting }
  #       # redirect_to
  #     else
  #       format.html { render :new }
  #       format.json { render json: @meeting.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

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
    # regenerate_all_available_time_to_database

    clean
    if current_user.is_doctor
      @meetings = Meeting.where(category: "Doctors").where.not(user_holder_id: current_user.id).where(status: "available").where('start_time >= ?',  Time.now.utc).order :start_time
    else
      @meetings = Meeting.where(category: "Patients").where(status: "available").where('start_time >= ?',  Time.now.utc).order :start_time
    end


    @something = current_user.id
    @booked = Meeting.where(patient_id: current_user.id)
    # @meetings = Meeting.where(patient_id: [nil, ""]).where('start_time >= ?',  Time.now.utc).order :start_time
    # @meetings = Meeting.where(status: "available").where('start_time >= ?',  Time.now.utc).order :start_time
  end

  def book
    # respond_to do |format|
    @meeting = Meeting.where(:id =>params[:meeting_id]).first
    # @meeting.patient_id = params[:id]
    # @meeting.status = "pending"
  end
    # @meeting.save
    #   format.html { redirect_to show_doctor_schedule_path, notice: 'Meeting was successfully booked.' }
    #   format.json { render :show, status: :ok, location: @meeting }
    # end
  # end

  def confirm
    change("confirmed")
    # respond_to do |format|
    #   @meeting = Meeting.where(:id =>params[:meeting_id]).first
    #   @meeting.status = "confirmed"
    #   if @meeting.save
    #     format.html { redirect_to user_holder_meetings_path(@meeting.user_holder_id), notice: 'Meeting was confirmed.' }
    #     format.json { render :show, status: :ok, location: @meeting }
    #   end

    # end

  end


  def reject
    change("rejected")
    # respond_to do |format|
    #   @meeting = Meeting.where(:id =>params[:meeting_id]).first
    #   @meeting.status = "rejected"
    #   if @meeting.save!
    #     format.html { redirect_to user_holder_meetings_path(@meeting.user_holder_id), notice: 'Meeting was rejected.' }
    #     format.json { render :show, status: :ok, location: @meeting }
    #   end

    # end


  end

  def change(nextstatus)
    respond_to do |format|
      @meeting = Meeting.where(:id =>params[:meeting_id]).first
      @meeting.status = nextstatus
      if @meeting.save!
        format.html { redirect_to user_holder_meetings_path(@meeting.user_holder_id), notice: 'Meeting was ' + nextstatus + '.' }
        format.json { render :show, status: :ok, location: @meeting }
      end

    end

  end

  def show_patient_appointment
    @meeting = Meeting.where(:id =>params[:meeting_id]).first

  end



  def book_edit


    respond_to do |format|
      # if @meeting.update(meeting_params)
      @meeting = Meeting.where(:id =>params[:meeting_id]).first
        @meeting.status = "pending"
        @meeting.patient_id = params[:id]
        @meeting.location = params[:meeting][:location]
        @meeting.description = params[:meeting][:description]
        if @meeting.save
          format.html { redirect_to show_doctor_schedule_path, notice: 'Meeting was successfully booked.' }
          format.json { render :show, status: :ok, location: @meeting }
          send_notification(@meeting)
        end
      # else
      #   format.html { render :edit }
      #   format.json { render json: @meeting.errors, status: :unprocessable_entity }
      # end
    end



  end


  def send_notification(meeting)
    # @patient = @meeting.patient_id
    @patient = UserHolder.find(meeting.patient_id)
    @doctor = UserHolder.find(meeting.user_holder_id)
    @first_name = @patient.first_name
    @last_name = @patient.last_name
    @name = @first_name + ' ' + @last_name


    # @first_name, @last_name = documentation.patient.split
    @current_setting = @doctor.user_setting

    # unless @current_setting.nil?
      # if @current_setting.email_notification
          @cur_user_email = @doctor.email
      # end
      # if @current_setting && @current_setting.email_notification
      #     @cur_user_email = @cur_user.email

          @message = Message.new(:sender_name => @name)
          @message.receiver_email = @cur_user_email
          MessageMailer.book_notification(@message).deliver
          # if @cur_user_email != ""
          #     @message.sender_email =  @cur_user_email
          #     MessageMailer.document_confirmation(@message).deliver
          # end
      # end
    # end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:name, :start_time, :end_time, :category)
    end
end
