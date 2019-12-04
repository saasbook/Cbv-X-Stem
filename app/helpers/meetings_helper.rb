module MeetingsHelper

  def ten_slot_generator_capped_within_week(res, meetings_doctor, doctor_id, available_slot_num)
    res = []
    num_count, day_count = available_slot_num,0
    current = Time.now

    while num_count < 5 && day_count < 7
      meeting_day =  meetings_doctor.select{|t| t.day == current.day + day_count}.map{|t| t.hour}
      basic_time_frame.each do |start_hour|
        if !meeting_day.include?(start_hour)
          time_to_add_year = (current + day_count.day).year
          time_to_add_month = (current + day_count.day).month
          time_to_add_day = (current + day_count.day).day
          time_to_add = Time.new(time_to_add_year,time_to_add_month,time_to_add_day, start_hour, 00, 00 , "+00:00")
          if time_to_add >=  Time.now.utc + 2.hour then
            res += [[time_to_add, doctor_id]]
            num_count += 1
            if num_count >=5 then break end
          end
        end
      end
      day_count +=1
    end
    res
  end

  def regenerate_all_available_time_list
    res = []
    User.where("role='doctor' and email != 'testuser01@testuser.com'").each do |doctor|
      meetings_doctor = doctor.user_holder.meetings.nil? ? [] : doctor.user_holder.meetings.pluck(:start_time)
      # final version should only filter out occupied time slot.
      # meetings_doctor = doctor.user_holder.meetings.nil? ? [] : doctor.user_holder.meetings.where('patient_id != ""').pluck(:start_time)
      available_slot_num = doctor.user_holder.meetings.nil? ? [] : doctor.user_holder.meetings.where(patient_id: [nil, '']).pluck(:start_time).length
      res +=ten_slot_generator_capped_within_week(res, meetings_doctor, doctor.id, available_slot_num)
    end
    res
  end

  def regenerate_all_available_time_to_database
    regenerate_all_available_time_list
    regenerate_all_available_time_list.each do |dou|
      doctor = User.find_by_id(dou[1])
      doctor.user_holder.meetings.create!(start_time: dou[0], end_time: dou[0]+1.hour)
    end
  end

  def basic_time_frame
    # Nine to Five
    (9..17)
  end

  def get_all_doctor_meetings

  end

end
