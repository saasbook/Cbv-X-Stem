class AppointmentsController < ApplicationController
  before_action :get_user_holder
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = @user_holder.appointments
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = @user_holder.appointments.build
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = @user_holder.appointments.build(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to user_holder_appointments_path(@user_holder), notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to user_holder_appointments_path(@user_holder), notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to user_holder_appointments_path(@user_holder), notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def get_user_holder
      @user_holder = UserHolder.find(params[:user_holder_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = @user_holder.appointments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:patient, :location, :start, :end, :user_holder_id)
    end
end
