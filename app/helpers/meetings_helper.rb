module MeetingsHelper
#
#   def ten_slot_generator_capped_within_week(res, meetings_doctor, doctor_id, available_slot_num)
#     res = []
#     num_count, day_count = available_slot_num,0
#     current = Time.now
#
#     while num_count < 5 && day_count < 7
#       meeting_day =  meetings_doctor.select{|t| t.day == current.day + day_count}.map{|t| t.hour}
#       basic_time_frame.each do |start_hour|
#         if !meeting_day.include?(start_hour)
#           time_to_add_year = (current + day_count.day).year
#           time_to_add_month = (current + day_count.day).month
#           time_to_add_day = (current + day_count.day).day
#           time_to_add = Time.new(time_to_add_year,time_to_add_month,time_to_add_day, start_hour, 00, 00 , "+00:00")
#           if time_to_add >=  Time.now.utc + 2.hour then
#             res += [[time_to_add, doctor_id]]
#             num_count += 1
#             if num_count >=5 then break end
#           end
#         end
#       end
#       day_count +=1
#     end
#     res
#   end
#
#   def regenerate_all_available_time_list
#     res = []
#     User.where("role='doctor' and email != 'testuser01@testuser.com'").each do |doctor|
#       meetings_doctor = doctor.user_holder.meetings.nil? ? [] : doctor.user_holder.meetings.pluck(:start_time)
#       # final version should only filter out occupied time slot.
#       meetings_doctor = doctor.user_holder.meetings.nil? ? [] : doctor.user_holder.meetings.where('status != "available"').pluck(:start_time)
#       available_slot_num = doctor.user_holder.meetings.nil? ? [] : doctor.user_holder.meetings.where('status = "available"').pluck(:start_time).length
#       res +=ten_slot_generator_capped_within_week(res, meetings_doctor, doctor.id, available_slot_num)
#     end
#     res
#   end
#
#   def regenerate_all_available_time_to_database
#     regenerate_all_available_time_list
#     regenerate_all_available_time_list.each do |dou|
#       doctor = User.find_by_id(dou[1])
#       # doctor.user_holder.meetings.create!(start_time: dou[0], end_time: dou[0]+1.hour)
#       doctor.user_holder.meetings.create!(start_time: dou[0], end_time: dou[0]+1.hour, category: "Patients", status: "available")
#     end
#   end
#
#   def basic_time_frame
#     # Nine to Five
#     (9..17)
#   end
#
#   def get_all_doctor_meetings


#
#   end



   def clean 
    current = DateTime.now
    for d in 0..6
        aday = (current + d.day).day 
        check = DateTime.new(current.year,current.month,aday, 9, 00, 00)
        if (Meeting.where(start_time: check).length == 0) 
            # for t in 9..16
            #     starttime = DateTime.new(current.year,current.month,aday, t, 00, 00)
            #     endtime = DateTime.new(current.year,current.month,aday, t+1, 00, 00)
            #     generate_slot(starttime, endtime)
            # end
            generate_slots(current, aday)
        end
    end  
   end

   def generate_slots(current, aday)
    for t in 9..16
        starttime = DateTime.new(current.year,current.month,aday, t, 00, 00)
        endtime = DateTime.new(current.year,current.month,aday, t+1, 00, 00)
        generate_slot(starttime, endtime)
    end
end

   def generate_slot(starttime, endtime)
      User.all.each { |user|
         if user.is_doctor
            Meeting.create(start_time: starttime, end_time: endtime, user_holder_id: user.id, status: "available", category: "Patients")
         end
      }
 end






end
